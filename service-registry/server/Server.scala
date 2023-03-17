//> using scala "3.2.2"
//> using lib "com.lihaoyi::cask:0.8.3"
//> using lib "com.lihaoyi::upickle:3.0.0"

import java.time.format.*
import scala.util.*
import Properties.*
import java.time.*

import upickle._
import upickle.default._
import upickle.default.{ReadWriter => RW, macroRW}

/** @param url The URL where to load the web-component
  * @param component the component name
  */
case class WebComponent(url: String, component: String)
object WebComponent{
  given rw: RW[WebComponent] = macroRW
}

given ReadWriter[ZonedDateTime] = readwriter[String].bimap[ZonedDateTime](
  zonedDateTime => DateTimeFormatter.ISO_INSTANT.format(zonedDateTime),
  str => ZonedDateTime.parse(str, DateTimeFormatter.ISO_INSTANT))
  
/** The register request body */
case class Register(webComponent : WebComponent, label : String, tags : Set[String])
object Register{
  given rw: RW[Register] = macroRW
}

case class Service(service : Register, lastUpdated : ZonedDateTime = ZonedDateTime.now())
object Service{
  given rw: RW[Service] = macroRW
}


/**
  * package/run with: 
  * {{{
  *   which scala-cli || brew install Virtuslab/scala-cli/scala-cli
  *   scala-cli package Server.scala -o app.jar -f --assembly
  *   java -jar app.jar
  * }}}
  * 
  * or:
  * 
  * {{{ scala-cli Server.scala }}}
  * 
  * Test with:
  * {{{
  * curl -X POST -d '{"webComponent":{"url":"dave","component":"susan"},"label":"example","tags":["some","app"]}' http://localhost:8080/api/v1/registry/foo
  * }}}
  * 
  * 
  * scala-cli setup-ide
  */
object App extends cask.MainRoutes {

  private var serviceById = Map[String, Service]()

  @cask.get("/")
  def getRoot() = s"""GET /api/v1/registry/:id
                     |POST /api/v1/registry/:id""".stripMargin

  @cask.post("/api/v1/registry/:id")
  def register(id : String, request: cask.Request) = {
    val body = read[Register](request.text())
    serviceById = serviceById.updated(id, Service(body, ZonedDateTime.now()))
    write(body)
  }

  @cask.getJson("/api/v1/registry")
  def list() = writeJs(serviceById)

  @cask.get("/api/v1/registry/:id")
  def get(id :String) = serviceById.get(id).map(x => write(x)).getOrElse(write(Map.empty))

  @cask.get("/health")
  def getHealthCheck() = s"${ZonedDateTime.now(ZoneId.of("UTC"))}"
  

  override def host: String = "0.0.0.0"
  override def port = envOrElse("PORT", propOrElse("PORT", 8080.toString)).toInt

  initialize()

  println(s""" 🚀 running on $host:$port {verbose : $verbose, debugMode : $debugMode }  🚀""")
}
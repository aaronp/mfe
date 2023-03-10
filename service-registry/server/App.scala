//> using scala "3.2.2"
//> using lib "com.lihaoyi::cask:0.8.3"
//> using lib "com.lihaoyi::upickle:3.0.0-M2"

import scala.util.*
import Properties.*
import java.time.*

import upickle._
import upickle.default._
import upickle.default.{ReadWriter => RW, macroRW}

case class WebComponent(url: String, component: String)
object WebComponent{
  implicit val rw: RW[WebComponent] = macroRW
}


case class Register(webComponent : WebComponent, label : String, tags : Set[String])
object Register{
  implicit val rw: RW[Register] = macroRW
}

/**
  * package/run with: 
  * {{{
  *   which scala-cli || brew install Virtuslab/scala-cli/scala-cli
  *   scala-cli package App.scala -o app.jar -f --assembly
  *   java -jar app.jar
  * }}}
  * 
  * or:
  * 
  * {{{ scala-cli App.scala }}}
  * 
  * Test with:
  * {{{
  * curl -X POST -d '{"webComponent":{"url":"dave","component":"susan"},"label":"example","tags":["some","app"]}' http://localhost:8080/api/v1/registry/foo
  * }}}
  */
object App extends cask.MainRoutes {

  private var byId = Map[String, Register]()

  @cask.get("/")
  def getRoot() = s"""GET /api/v1/registry/:id
                     |POST /api/v1/registry/:id""".stripMargin

  @cask.post("/api/v1/registry/:id")
  def register(id : String, request: cask.Request) = {
    val body = read[Register](request.text())
    println(s"body is $body")
    byId = byId.updated(id, body)
    write(body)
  }

  @cask.getJson("/api/v1/registry")
  def list() = writeJs(byId)


  @cask.get("/api/v1/registry/:id")
  def get(id :String) = byId.get(id).map(x => write(x)).getOrElse(write(Nil))

  @cask.get("/health")
  def getHealthCheck() = s"${ZonedDateTime.now(ZoneId.of("UTC"))}"
  

  override def host: String = "0.0.0.0"
  override def port = envOrElse("PORT", propOrElse("PORT", 8080.toString)).toInt

  initialize()

  println(s""" 🚀 running on $host:$port {verbose : $verbose, debugMode : $debugMode }  🚀""")
}
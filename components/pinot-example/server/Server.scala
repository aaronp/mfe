//> using scala "3.2.2"
//> using lib "com.lihaoyi::cask:0.9.0"
//> using lib "com.lihaoyi::upickle:3.0.0"
//> using lib "org.apache.pinot::pinot-java-client:0.9.3"

import java.time.format.*
import scala.util.*
import Properties.*
import java.time.*

import org.apache.pinot.client.*

import upickle.*
import upickle.default.*
import upickle.default.{ReadWriter => RW, macroRW}


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
  * scala-cli setup-ide
  */
object Server extends cask.MainRoutes {

  def reply(body : ujson.Value) = cask.Response(
    data = body,
    headers = Seq("Access-Control-Allow-Origin" -> "*",
      "Content-Type" -> "application/json")
  )

  @cask.get("/")
  def getRoot() = s"""GET /api/v1/registry/:id
                     |POST /api/v1/registry/:id""".stripMargin


  @cask.get("/health")
  def getHealthCheck() = s"${ZonedDateTime.now(ZoneId.of("UTC"))}"

  override def host: String = "0.0.0.0"
  override def port = envOrElse("PORT", propOrElse("PORT", 8080.toString)).toInt

  initialize()

  println(s""" 🚀 running pinot BFF on $host:$port {verbose : $verbose, debugMode : $debugMode }  🚀""")
}
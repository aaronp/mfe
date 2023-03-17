//> using scala "3.2.2"
//> using lib "com.lihaoyi::requests:0.8.0" 

/**
 * run locally using:
  * {{{
  *   # register a component:
  *   args are <id> <json body> <hostport>
  *   scala-cli Client.scala --main-class register -- foo '{"webComponent":{"url":"dave","component":"susan"},"label":"example","tags":["some","app"]}' http://localhost:8080
  * 
  *   # list components:
  *   args are <hostport>
  *   scala-cli Client.scala --main-class list -- http://localhost:8080
  * 
  *   # get a component:
  *   args are <id> <hostport>
  *   scala-cli Client.scala --main-class get -- foo http://localhost:8080
  * }}}
  * 
  * or 
  * 
  * {{{
  *   which scala-cli || brew install Virtuslab/scala-cli/scala-cli
  *   scala-cli package Client.scala -o client.jar -f --assembly
  *   java -jar client.jar
  * }}}
  * 
  */
def env(key : String) = sys.env.getOrElse(key, sys.error(s"$key env variable not sent"))
@main def register(id : String = env("ID"),  body : String = env("BODY"),  hostPort : String = env("HOSTPORT")) = {
  val url = s"$hostPort/api/v1/registry/$id"
  val response = requests.post(url, data = body)
  println(response)
  response.ensuring(_.statusCode == 200, s"$url returned ${response.statusCode}: $response")
}

@main def get(id : String = env("ID"), hostPort : String = env("HOSTPORT")) = {
  val url = s"$hostPort/api/v1/registry/$id"
  val response = requests.get(url)
  println(response.text())
  response.ensuring(_.statusCode == 200, s"$url returned ${response.statusCode}: $response")
}

@main def list(hostPort : String = env("HOSTPORT")) = {
  val url = s"$hostPort/api/v1/registry"
  val response = requests.get(url)
  println(response.text())
  response.ensuring(_.statusCode == 200, s"$url returned ${response.statusCode}: $response")
}
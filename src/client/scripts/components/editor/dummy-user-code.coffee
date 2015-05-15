module.exports =
  """
  // This scrollable area is the code editor with syntax highlighting for Scala.

  // Once the application has loaded we can display a sample strategy code here
  // so that the user understands immediately what needs to be done.

  // Dummy code below:
  package examples.actors

  import scala.actors.Actor
  import scala.actors.Actor._

  abstract class PingMessage
  case object Start extends PingMessage
  case object SendPing extends PingMessage
  case object Pong extends PingMessage

  abstract class PongMessage
  case object Ping extends PongMessage
  case object Stop extends PongMessage

  object pingpong extends Application {
    val pong = new Pong
    val ping = new Ping(100000, pong)
    ping.start
    pong.start
    ping ! Start
  }
  """

//Importing libraries for program 
import java.io.File
import java.util.Random
import scala.io.Source

//Declaring variables 
var name : String = _
var mood : String = _
var art : String = _

//Data Structures
var userData = collection.mutable.Map[String, String]()
val artList = collection.mutable.Map[Int, String]()

//Reading in list of art pieces
Source.fromFile("ArtList.txt").getLines.foreach { line => 
  val data = line.split("~")
  artList.put(data(0).toInt, data(1))
}

//Function to read user data
def getData(name: String) : Unit = {
  //Read file
  val fileName = name + ".txt"
  Source.fromFile(fileName).getLines.foreach { line => 
    val data = line.split("~")
    userData.put(data(0), data(1))
  }
  println("Welcome back, " + name + "!")
  println("Your last recorded mood was " + userData("mood"))
}

//Function to generate random art piece
def generatePiece(mood: String) : Unit = {
	val randomNumber = new Random().nextInt(artList.size)
	var piece = artList(randomNumber)
  art = piece
  
	println("Based on your current mood of " + mood + ", I've chose the following art piece for you: ")
	println(piece)
}

//Function to record mood
def logMood(name: String, mood: String, art: String) : Unit = {
	userData.put("mood", mood)
	userData.put("art piece", art)

	val dataFile = new File(name + ".txt")
	val writer = new PrintWriter(dataFile)
	userData.foreach{ case (k, v) => writer.write(k + "~" + v + "\n") }
	writer.close()
}

//Main Function 
def main() : Unit = {
	println("Hello, this is a mental health program that uses art therapy techniques to support individuals with mental health challenges.")
	println("What is your name?")
	name = scala.io.StdIn.readLine()
	
	if(new File(name + ".txt").exists) {
		getData(name)
	}

	println("Please rate your current mood on a scale of 1 to 10.")
	mood = scala.io.StdIn.readLine()
	
	generatePiece(mood)
	logMood(name, mood, art)
	println("Your data has been recorded. Thank you for using this program.")
}

main()
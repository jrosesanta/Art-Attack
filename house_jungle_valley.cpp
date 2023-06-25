#include<iostream>
#include<string>
#include<fstream>
using namespace std;

//defining a function to create an art Attack
void createArtAttack(string filename)
{
//definig the stream for file handling
ofstream file_to_write;

//open the file in write mode
file_to_write.open(filename, ios::out);

//writing the design for Art Attack
file_to_write<<"************************** \n";
file_to_write<<"*    * **  *    *   *    * \n";
file_to_write<<"*    * **  *   *    *    * \n";
file_to_write<<"*    * **  *  *     *    * \n";
file_to_write<<"******* **  * *      *    * \n";
file_to_write<<"*    * **  **       ******* \n";
file_to_write<<"*    * **  * *      *    * \n";
file_to_write<<"*    * **  *  *     *    * \n";
file_to_write<<"*    * **  *   *    *    * \n";
file_to_write<<"*    * **  *    *   *    * \n";
file_to_write<<"************************** \n";

//closing the file 
file_to_write.close();

}

int main()
{
//creating an art attack
createArtAttack("ArtAttack.txt");

return 0;
}
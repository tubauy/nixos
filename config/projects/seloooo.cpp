
#include <iostream>
#include <string>

using namespace std;

int main()
{
    cout << "Greeting! I am the palindrome decider!";
    cout << endl;

    string word;

    // Get a word from the user

    //Set an integer count to 0
    bool word_pal;

    while (true) { 
        cout << "Please enter a word: ";
        cin >> word;
        int length = word.length();
        word_pal= true;

        for (int i = 0; i < length; i++) {
            if (word[i] != word[(length-1)-i]) {
                word_pal=false;
            }
        }
        if (word_pal) {
            cout << "Your word is a palindrome! Fantastic!";
            continue;
        }
        else { 
            word_pal= true;
            for (int i = 0; i < 3; i++) {
                if (word[i] != word[(length-1)-i]) {
                    word_pal=false;
                }
            }
            if (word_pal) {
                cout << "Not quite a palindrome, but close enough.";
                continue;
            }
        }
        cout << "Your word is NOT a palindrome. Thanks anyway!";
        break;
    }
    return 0;
}

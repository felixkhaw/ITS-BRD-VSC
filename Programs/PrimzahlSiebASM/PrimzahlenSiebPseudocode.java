import java.util.Arrays;

public class PrimzahlenTest {
    public static void main(String[] args) {
		/*
			Das Sieb von Eratosthenes in Java:
			Ein Problem ist das klassische Arrays in Java statisch sind und da die Menge der Primzahlen am Anfang noch nicht bekannt ist lässt sich das auf diese Weise nicht abbilden.
			Die einzige statische bekannte Größe sind die 1000 Zahlen. Wenn man die Zahlen als Boolean Array anlegen würde,
			könnte man die Zahl zum einen gut streichen und der Index würde die Zahl repräsentieren um die es geht.
		*/

		//Boolean Array wird initialisiert mit 1000 Feldern vom Typ Boolean
		boolean[] zahlen = new boolean[1001]; // 1001 weil der Index bei Null beginnt und damit

		// Durchläuft zahlen und setzt alles Werte auf True weil sie mit false initialisiert worden sind.
		for(int o = 0; o<zahlen.length; o++){ // zahlen.length=1000
			zahlen[o]=true;	
			// System.out.println(o); // Wenn zahlen initialisiert wird mit 1000 Feldern dann geht der Index je nach Operator bis 999; kann zu Fehlern führen
		}
		
		// Hat 1000 Durchläufe; Schleife Variable i wird um 1 erhöht nach Lauf. Schleifenvariable wird benutzt um Arrayfelder von Zahlen anzusprechen
		for(int i = 2; i<zahlen.length; i++){
			if(zahlen[i] == true){  //getrichen=false; Wenn noch nicht gestrichen dann führe aus...
				/*
					Nachfolgend streicht die for-Schleife alle Vielfachen
					Beispiel: erster Durchlauf
					i steht auf 2
					j wird mit i initialisiert und hat den Wert 2
					Die Abbruchbedingung ist i*j also 2*2 in der ersten Runde danach 2*3
					j ist quasi der Faktor und i die erste Primzahl
				*/
				for(int j = i; i*j<zahlen.length; j++){
					// Der Status des Vielfachen wird auf gestrichen/false gesetzt.
					zahlen[i*j] = false;
				}
			}
		}
		// Ausgabe: Alle zahlen die noch auf True sind werden ausgegeben. Wobei die eigentliche Zahl ja die Stelle des Feldes ist also über den Index.
		for(int a = 2; a < zahlen.length; a++){
			if(zahlen[a]){
				System.out.print(" " + a);
			}
		}
  	}
}

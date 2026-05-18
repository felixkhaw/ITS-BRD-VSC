import java.util.Arrays;

public class PrimzahlenTest {
    public static void main(String[] args) {
		/*
			Um das Sieb von Eratosthenes in Java:
			Ein Problem ist das klassische Arrays in Java statisch sind 
			und da die Menge der Primzahlen am Anfang noch nicht bekannt sind
			lässt sich das auf diese Weise nicht abbilden. Die einzige statische bekannte Größe
			sind die 1000 Zahlen. Wenn man die Zahlen als Boolean Array anlegen würde könnte man
			die Zahl zum einen gut streichen und der Index würde die Zahl repräsentieren um die es geht.
		*/
		boolean[] zahlen = new boolean[1001]; // 1001 weil Index bei 0 beginnt; wird initialisiert mit false
		for(int o = 0; o<zahlen.length; o++){
			zahlen[o]=true;		
		}
		for(int i = 2; i<zahlen.length; i++){ // false bedeutet Zahl ist nicht gestrichen
			if(zahlen[i] == true){  // Wenn noch nicht gestrichen dann berückstigen
				for(int j = i; i*j<zahlen.length; j++){
					zahlen[i*j] = false;
				}
			}
		}
		// Ausgabe
		for(int a = 0; a < zahlen.length; a++){
			if(zahlen[a]){
				System.out.println(a);
			}
		}
  	}
}

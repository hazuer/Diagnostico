
package diagnostico;

import org.jpl7.Query;

public class Diagnostico {


        public static void main(String[] args) {

        String lista="";
        String t1 = "consult('sintomas.pl')"; //Variable que guarda la consulta del archivo prolog
        Query q1 = new Query(t1);
        System.out.println( t1 + " " + (q1.hasSolution() ? "succeeded" : "failed") ); 
        String t2="diag(nauseas)";//Gurda consulta, regla de prolog
        Query q2 = new Query(t2);
        String action = q2.oneSolution().get("Y").toString();
        System.out.println("El reultado es :  "+ action);
        }

    }
    


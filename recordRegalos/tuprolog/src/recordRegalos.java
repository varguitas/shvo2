
/* Estas clases están incluidas en la librería "java.io.*"
import java.io.BufferedReader;
import java.io.FileReader;
 */
import alice.tuprolog.*; //Librería de incorporación de motor de Prolog al programa
import java.io.*; //Librería de entrada y salida de Java
import java.util.StringTokenizer;

//Clase para prueba de conexión
public class recordRegalos {
    //Método para leer la BC y almacenarla en un string para el motor de prolog
    public static String leerArchivo(String nombre){ //El parametro nombre indica el nombre del archivo
        try{
            File f;
            FileReader lectorArchivo;
            //Creamos objeto del archivo que vamos a leer
            f= new File(nombre);
            //Creamos el objeto FileReader que abrira el flujo(Stream) de datos para realizar la lectura
            lectorArchivo = new FileReader(f);
            //Creamos un lector en buffer para recopilar datos a travez del flujo "lectorArchivo" que hemos creado
            BufferedReader br = new BufferedReader(lectorArchivo);
            //Esta variable "l" almacena más adelante toda la lectura del archivo
            String l="";
            //Variable auxiliar
            String aux="";
            while (true){
                //Leemos una linea del texto y lo almacenamos en la variable auxiliar
                aux=br.readLine();
                if (aux!=null){ //Si el auxiliar es diferente de nulo entonces ->
                    l=l+aux+"\n"; //a la variable "l" le agregamos el auxiliar más el caracter de new line
                }
                else{
                    break;
                }
            }
            br.close(); //Cierre del buffer
            lectorArchivo.close(); //Cierre del Stream de datos
            return l; //Retorna la variable "l"
        }
        catch (IOException e){ //Error de lectura del archivo
            System.out.println("Error: "+e.getMessage());
        }
        return null;
    }
    public static void main(String [] args) throws Exception{ //Main
        String record=recordRegalos();
        System.out.println(record);
    }
    public static String recordRegalos() throws Exception{
        String BC = leerArchivo("base.pl"); //Variable BC almacena la base de conocimientos
        //System.out.println(BC);
        Prolog engine = new Prolog(); //Inicio el motor de prolog al cual llamamos "engine" 
        engine.setTheory(new Theory(BC));
        Term consulta = Term.createTerm("listaRecord(X)"); //Creamos un termino paraa hacer la consulta
        SolveInfo info=engine.solve(consulta);//trata de resolver la consulta que le realicemos
        if(info.isSuccess()){ //Si la consulta tiene éxito ->
            //Term solution = info.getSolution(); //"solution" de tipo Term, almacena la solución de la consulta
            Term result = info.getTerm("X");//"result" de tipo Term, almacena el valor de la Variable X de la anterior consulta
            String resultado = result.toString();
            return resultado;
            //String resultado=result.toString();//"resultado" almacena el String del valor de "result" que es de tipo Term
            //System.out.println(resultado);
            //System.out.println(solution);
        }
        else{
            return "Fail : " + info;
        }
        
    }
    
    /* Código de Respaldo
    public static String[] convierte(String respuesta){
        String str2array=respuesta;
        //1. First method with split() 
        // split(String Delimiter)
        String[] arr=str2array.split(",");
        System.out.println("Array: "+arr.length);
        for(int i=0;i<arr.length;i++)
        {
            System.out.println("array"+i+"  :"+arr[i]);
        }

        //2. Second Method of StringTokenizer
        // StringTokenizer(String str, String delimiter)
        StringTokenizer stArr=new StringTokenizer(str2array,",");

        while(stArr.hasMoreTokens())
        {
            System.out.println("Token: "+stArr.nextToken());
        }
        return arr;
    }
    
    
    
     * public static void main(String [] args) throws Exception{ //Main
        BufferedReader in = new BufferedReader(new FileReader("prueba.pl")); //Se carga el archivo donde está almacenada la BC
        Prolog engine = new Prolog(); 
        String theory = in.readLine();
        engine.setTheory(new Theory(theory));
        SolveInfo info=engine.solve("estudiante(X,Y,Z).");
        System.out.println(info.getSolution());
    }
     */
}

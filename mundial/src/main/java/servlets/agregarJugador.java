/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.Jugador;
import com.mundo.mundial.gestionarJugadores;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@MultipartConfig
@WebServlet(name = "AgregarJugador", urlPatterns = {"/AgregarJugador"})
public class agregarJugador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    ArrayList<Jugador> jugadores = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = getServletContext();
        String nombreJugador = request.getParameter("nombreJugador");
        int edad = Integer.parseInt(request.getParameter("edad"));
        double altura = Double.parseDouble(request.getParameter("altura"));
        double peso = Double.parseDouble(request.getParameter("peso"));
        double salario = Double.parseDouble(request.getParameter("salario"));
        String posicion = request.getParameter("posicion");
        String NombreEquipo = request.getParameter("NombreEquipo");

        Part file = request.getPart("foto");
        String nombreArchivo = file.getSubmittedFileName();

        System.out.println("Nombre del jugador: " + nombreJugador);
        System.out.println("Edad: " + edad);
        System.out.println("Altura: " + altura);
        System.out.println("Peso: " + peso);
        System.out.println("Salario: " + salario);
        System.out.println("Posición: " + posicion);
        System.out.println("Foto: " + nombreArchivo);
        System.out.println("NombreEquipo: " + NombreEquipo);

        jugadores = gestionarJugadores.leerJugadoresDesdeArchivo(context);

        // Agregar el jugador a la lista
        jugadores = gestionarJugadores.agregarJugadores(nombreJugador, edad, altura, peso, salario, posicion, nombreArchivo, NombreEquipo, jugadores);

        gestionarJugadores.escribirJugadoresEnArchivo(jugadores, context);

        // Obtener la ruta absoluta del directorio de imágenes dentro del proyecto
        String rutaRelativa = "imagenesJugadores";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File carpeta = new File(rutaAbsoluta);

        // Verificar si la carpeta existe, si no existe, crearla
        if (!carpeta.exists()) {
            carpeta.mkdirs(); // Crea la carpeta y todas las subcarpetas necesarias
        }

        // Ruta completa del archivo de imagen
        String rutaImagen = carpeta + File.separator + nombreArchivo;

        // Mover el archivo al directorio de imágenes
        Files.copy(file.getInputStream(), Paths.get(rutaImagen), StandardCopyOption.REPLACE_EXISTING);

        // Redireccionar de vuelta al index.jsp
        response.sendRedirect("index.jsp");
    }
}

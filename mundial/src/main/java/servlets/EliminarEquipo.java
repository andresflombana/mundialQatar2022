/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.Equipo;
import com.mundo.mundial.gestionarEquipos;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/EliminarEquipo")
public class EliminarEquipo extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreEquipo = request.getParameter("nombreEquipo");

        // Obtener la lista de equipos desde el contexto de la aplicación
        ArrayList<Equipo> misEquipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());

        // Eliminar el equipo de la lista utilizando un iterador
        Iterator<Equipo> iterator = misEquipos.iterator();
        while (iterator.hasNext()) {
            Equipo equipo = iterator.next();
            if (equipo.getNombreEquipo().equals(nombreEquipo)) {
                iterator.remove();
                break;
            }
        }

        // Escribir la lista actualizada en el archivo
        gestionarEquipos.escribirEquiposEnArchivo(misEquipos, getServletContext());

        // Redirigir de vuelta a la página index.jsp o a donde sea necesario
        response.sendRedirect("index.jsp");
    }
}

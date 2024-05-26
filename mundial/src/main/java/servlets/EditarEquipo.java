/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.Equipo;
import com.mundo.mundial.gestionarEquipos;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet("/EditarEquipo")
public class EditarEquipo extends HttpServlet {

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    // Obtener los parámetros del formulario de edición
    String nombreEquipo = request.getParameter("nombreEquipo");
    String director = request.getParameter("director");
    String equipoID = request.getParameter("equipoID");

    // Obtener el archivo de escudo adjunto (si se proporciona)
    Part filePart = request.getPart("escudo");

    // Obtener la lista de equipos desde el contexto de la aplicación
    ArrayList<Equipo> misEquipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());

    // Buscar y editar el equipo en la lista
    for (Equipo equipo : misEquipos) {
        if (equipo.getNombreEquipo().equals(equipoID)) {
            // Actualizar los datos del equipo
            equipo.setNombreEquipo(nombreEquipo);
            equipo.setDirector(director);

            // Verificar si se proporcionó un nuevo archivo de escudo
            if (filePart != null) {
                // Guardar el nuevo archivo de escudo en el servidor y actualizar la ruta del escudo en el equipo
                String fileName = guardarEscudo(filePart);
                equipo.setEscudo("imagenes/" + fileName);
            }
            break;
        }
    }

    // Escribir la lista actualizada de equipos en el archivo
    gestionarEquipos.escribirEquiposEnArchivo(misEquipos, getServletContext());

    // Actualizar la lista de equipos en el contexto de la aplicación
    getServletContext().setAttribute("misEquipos", misEquipos);

    // Redirigir de vuelta a la página index.jsp
    response.sendRedirect("index.jsp");
}

    // Método para guardar el archivo de escudo en el servidor
    private String guardarEscudo(Part filePart) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "imagenes";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        File file = new File(uploadDir, fileName);
        try {
            Files.copy(filePart.getInputStream(), file.toPath());
        } catch (IOException ex) {
            // Manejar el error al copiar el archivo
            ex.printStackTrace();
        }
        return fileName;
    }
}

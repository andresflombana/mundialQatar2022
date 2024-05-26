/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */
package servlets;

import com.mundo.mundial.Equipo;
import com.mundo.mundial.gestionarEquipos;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.util.ArrayList;
import javax.servlet.annotation.MultipartConfig;

@WebServlet(name = "AgregarEquipo", urlPatterns = {"/AgregarEquipo"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class agregarEquipo extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String nombreEquipo = request.getParameter("nombreEquipo");
        String director = request.getParameter("director");

        // Obtener el Part para el archivo adjunto
        Part filePart = request.getPart("escudo");

        // Verificar si el archivo adjunto existe
        if (filePart != null) {
            // Obtener el nombre del archivo
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Construir la ruta de carga del archivo
            String uploadPath = getServletContext().getRealPath("") + File.separator + "imagenes";

            // Crear el directorio de carga si no existe
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Construir el archivo de destino
            File file = new File(uploadDir, fileName);

            try (InputStream input = filePart.getInputStream()) {
                // Copiar el archivo de entrada al archivo de destino
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Obtener la lista de equipos existente desde el contexto de la aplicación
            ArrayList<Equipo> misEquipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());

            // Agregar el nuevo equipo a la lista
            misEquipos = gestionarEquipos.agregarEquipo(nombreEquipo, director, "imagenes/" + fileName, misEquipos);

            // Establecer la lista actualizada en el contexto de la aplicación
            getServletContext().setAttribute("misEquipos", misEquipos);

            // Escribir los equipos en el archivo
            gestionarEquipos.escribirEquiposEnArchivo(misEquipos, getServletContext());

            // Redirigir a alguna página de confirmación o a donde corresponda
            response.sendRedirect("index.jsp");
        } else {
            // Manejar el caso cuando no se adjunta ningún archivo
            // Por ejemplo, mostrar un mensaje de error o redirigir a una página de error
            response.getWriter().println("Error: No se ha adjuntado ningún archivo.");
        }
    }   
}
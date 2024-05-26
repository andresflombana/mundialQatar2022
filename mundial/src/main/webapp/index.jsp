<%-- 
    Document   : index
    Authors    : Andrés Lombana y Valentina Alvarez
--%>

<%@page import="java.util.List"%>
<%@page import="com.mundo.mundial.gestionarJugadores"%>
<%@page import="com.mundo.mundial.Jugador"%>
<%@page import="com.mundo.mundial.gestionarEquipos"%>
<%@page import="com.mundo.mundial.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="lib/header.jsp" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background-image: url("data/imagenes/fondo001.jpg");
        background-size: cover;
    }

    .card {
        border: 2px solid #7F1431;
        border-radius: 5px;
        margin-bottom: 20px;
        padding: 20px;
        background-color: rgba(255, 255, 255, 0.6);
        transition: transform 0.3s, box-shadow 0.3s;
    }

    .btn {
        background-color: #7F1431;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        margin: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .btn:hover {
        background-color: #cccccc;
        color: #000000;
    }

    .btn-submit {
        background-color: green;
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
    }

    .btn-cancel {
        background-color: red;
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
    }

    .select {
        background-color: #7F1431;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        margin: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .opciones {
        text-align: center;
    }

    .modal-content {
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        border: 3px solid #7F1431;
    }

    .modal-header {
        border-bottom: none;
        padding-bottom: 0;
    }

    .modal-title {
        color: #7F1431;
    }

    .modal-body {
        padding: 20px;
    }

    .modal-footer {
        border-top: none;
        padding-top: 0;
    }

    .modal-footer .btn {
        margin: 5px;
    }

    .slide .modal-dialog {
        transform: scale(0);
        transition: transform 0.3s ease;
    }

    .slide.show .modal-dialog {
        transform: scale(1);
    }

    /* Estilo para los cuadros de equipos */
    .equipo-container {
        border: 1px solid #ccc;
        background-color: #fff;
        padding: 10px;
        margin-bottom: 20px;
        width: 300px;
    }

    /* Estilo para los cuadros de jugadores */
    .jugador-container {
        border: 1px solid #ccc;
        background-color: #fff;
        padding: 10px;
        margin-bottom: 10px;
        width: 250px;
    }

</style>

<div class="col-md-12 sepatop">
    <div class="sepa">
        <!-- Acciones -->
        <center><p></p></center>
        <div class="btn-container sepatop ">
            <button type="button" class="btn btn-action1" data-bs-toggle="modal" data-bs-target="#agregarEquipoModal">Agregar Equipo</button>
            <button type="button" class="btn btn-action1" data-bs-toggle="modal" data-bs-target="#agregarJugadorModal">Agregar Jugador</button>
        </div>
    </div>
</div>

        <p></p>

<%-- Equipos --%>
<div class="col-md-7 mx-auto">
    <div class="card">
        <h4 class="text-center font-weight-bold">Listado de Equipos</h4> <!-- Agregar clase text-center -->
        <div class="card-body">
            <div class="row justify-content-center"> <!-- Centrar los elementos -->
                <!-- Mostrar cada equipo de la lista -->
                <% List<Equipo> equipos = gestionarEquipos.leerEquiposDesdeArchivo(getServletContext());
                    if (equipos != null && !equipos.isEmpty()) {
                        for (Equipo equipo : equipos) {
                %>
                <div class="col-md-4 mb-4">
                    <!-- Contenedor de equipo con fondo blanco y borde -->
                    <div class="equipo-container">
                        <div class="custom-card">
                            <div class="equipo-cell text-center"> <!-- Agregar clase text-center -->
                                <!-- Mostrar la imagen del escudo -->
                                <img src="<%= equipo.getEscudo()%>" style="width: 15rem; height: 20rem;" alt="Escudo del equipo">
                                <div class="equipo-text">
                                    <h4 class="card-text text-center"><%= equipo.getNombreEquipo()%></h4>
                                    <h5 class="card-text">Técnico: <%= equipo.getDirector()%></h5>
                                    <div class="card-footer justify-content-center">
                                        <!-- Botones para ver, editar y eliminar -->
                                        <button type="button" class="btn btn-action1" data-bs-toggle="modal" data-bs-target="#editarEquipoModal" onclick="cargarDatosEdicion('<%= equipo.getNombreEquipo()%>', '<%= equipo.getDirector()%>', '<%= equipo.getEscudo()%>')"><i class="fa fa-pencil"></i></button>
                                        <button type="button" class="btn btn-action1" onclick="eliminarEquipo('<%= equipo.getNombreEquipo()%>')"><i class="fa fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="verModal<%= equipo.getNombreEquipo()%>" tabindex="-1" aria-labelledby="verModalLabel<%= equipo.getNombreEquipo()%>" aria-hidden="true">
                </div>
                <% }
                } else {
                %>
                <div class="col-md-12" style="text-align: center;"><h5>No hay equipos registrados</h5></div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%-- Jugadores --%>
<div class="col-md-7 mx-auto">
    <div class="card">
        <h4 class="text-center font-weight-bold">Listado de Jugadores</h4>
        <div class="card-body">
            <div class="row justify-content-center"> <!-- Cambiar la clase a justify-content-center para centrar los elementos -->
                <!-- Mostrar cada jugador de la lista -->
                <% List<Jugador> jugadores = gestionarJugadores.leerJugadoresDesdeArchivo(getServletContext());
                    if (jugadores != null && !jugadores.isEmpty()) {
                        for (Jugador jugador : jugadores) {
                %>
                <div class="col-md-4 mb-4">
                    <div class="fut-player-card smaller-player-card text-center" style="background-color: white;"> <!-- Agregar clase text-center -->
                        <div class="player-card-top">
                            <div class="player-master-info">
                                <div class="player-position">
                                    <h4><%= jugador.getNombreEquipo()%></h4>
                                </div>
                            </div>
                            <div class="player-picture">
                                <img src="imagenesJugadores/<%= jugador.getFoto()%>" alt="Foto del jugador" draggable="false" style="width: 15rem; height: 20rem;"/>
                                <div class="player-extra">
                                    <h5><%= jugador.getPosicion()%></h5>
                                </div>
                            </div>
                        </div>

                        <div class="player-card-bottom">
                            <div class="player-info">
                                <div class="player-name">
                                    <h4><%= jugador.getNombreJugador()%></h4>
                                </div>
                                <div class="player-features">
                                    <div class="player-features-col">
                                        <span>
                                            <h5 class="player-feature-value">Edad:</h5>
                                            <h5 class="player-feature-title"><%= jugador.getEdad()%></h5>
                                        </span>
                                        <span>
                                            <h5 class="player-feature-value">Altura:</h5>
                                            <h5 class="player-feature-title"><%= jugador.getAltura()%></h5>
                                        </span>
                                        <span>
                                            <h5 class="player-feature-value">Peso:</h5>
                                            <h5 class="player-feature-title"><%= jugador.getPeso()%></h5>
                                        </span>
                                    </div>
                                    <!-- Línea de separación -->
                                    <hr>
                                    <!-- Botones de acción -->
                                    <div class="action-buttons mt-2"> <!-- Eliminar la clase text-center -->
                                        <button type="button" class="btn btn-action" data-bs-toggle="modal" data-bs-target="#editarJugadorModal<%= jugador.getNombreJugador()%>"><i class="fas fa-edit"></i></button>
                                        <button type="button" class="btn btn-action" onclick="eliminarJugador('<%= jugador.getNombreJugador()%>')"><i class="fas fa-trash-alt"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                } else { %>
                <div class="col-md-12" style="text-align: center;"><h5>No hay Jugadores registrados</h5></div>
                <% } %>
            </div>
        </div>
    </div>
</div>
     
<!-- Agregar Equipo Modal -->
<div class="modal fade" id="agregarEquipoModal" tabindex="-1" aria-labelledby="agregarEquipoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="agregarEquipoModalLabel">Agregar Equipo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Formulario para agregar un nuevo equipo -->
                <form action="AgregarEquipo" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre del Equipo:</label>
                        <input type="text" class="form-control" id="nombre" name="nombreEquipo" required>
                    </div>
                    <div class="mb-3">
                        <label for="tecnico" class="form-label">Nombre del Técnico:</label>
                        <input type="text" class="form-control" id="tecnico" name="director" required>
                    </div>
                    <div class="mb-3">
                        <label for="escudo" class="form-label">Escudo:</label>
                        <div class="btn-file">
                            <label class="btn btn-primary" for="escudo">
                                <i class="fas fa-upload"></i> Cargar archivo
                                <input type="file" id="escudo" name="escudo" accept="image/png, image/jpeg" style="display: none;" required>
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Agregar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Modal para agregar un nuevo Jugador -->
<div class="modal fade" id="agregarJugadorModal" tabindex="-1" aria-labelledby="agregarJugadorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="agregarJugadorModalLabel">Agregar Jugador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Formulario para agregar un nuevo jugador -->
                <form action="AgregarJugador" method="POST" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="nombreJugador" class="form-label">Nombre del Jugador:</label>
                            <input type="text" class="form-control" id="nombreJugador" name="nombreJugador" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="posicion" class="form-label">Posición del Jugador:</label>
                            <select class="form-select" id="posicion" name="posicion" required>
                                <option value="" selected disabled>Selecciona la posición</option>
                                <option value="Portero">Portero</option>
                                <option value="Defensa">Defensa</option>
                                <option value="Centrocampista">Centrocampista</option>
                                <option value="Delantero">Delantero</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="edad" class="form-label">Edad del Jugador:</label>
                            <input type="text" class="form-control" id="edad" name="edad" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="altura" class="form-label">Altura del Jugador:</label>
                            <input type="number" step="0.01" class="form-control" id="altura" name="altura" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="peso" class="form-label">Peso del Jugador:</label>
                            <input type="number" step="0.01" class="form-control" id="peso" name="peso" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="salario" class="form-label">Salario del Jugador:</label>
                            <input type="text" class="form-control" id="salario" name="salario" required>
                        </div>
                        <div class="col-md-12 mb-3">
                            <label for="equipoSelect" class="form-label">Equipo del Jugador:</label>
                            <select name="NombreEquipo" id="equipoSelect" class="form-select" required>
                                <option value="" selected disabled>Selecciona un equipo</option>
                                <% if (equipos != null && !equipos.isEmpty()) {
                                        for (Equipo equipo : equipos) {%>
                                <option value="<%=equipo.getNombreEquipo()%>"><%=equipo.getNombreEquipo()%></option>
                                <% }
                                    } %>
                            </select>
                        </div>
                        <div class="col-md-12 mb-3">
                            <label for="foto" class="form-label">Foto del Jugador:</label>

                            <label class="btn btn-primary" for="foto">
                                <i class="fas fa-upload"></i> Cargar archivo
                                <input type="file" id="foto" name="foto" accept="image/png, image/jpeg" style="display: none;" required>
                            </label>


                        </div>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="submit" class="btn btn-primary">Agregar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Modal de Edición de Equipo -->
<div class="modal fade" id="editarEquipoModal" tabindex="-1" aria-labelledby="editarEquipoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarEquipoModalLabel">Editar Equipo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Formulario para editar un equipo -->
                <form id="formEditarEquipo" action="EditarEquipo" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="equipoID" name="equipoID">
                    <div class="mb-3">
                        <label for="nombreEdit" class="form-label">Nombre del Equipo:</label>
                        <input type="text" class="form-control" id="nombreEdit" name="nombreEquipo" required>
                    </div>
                    <div class="mb-3">
                        <label for="directorEdit" class="form-label">Nombre del Director:</label>
                        <input type="text" class="form-control" id="directorEdit" name="director" required>
                    </div>
                    <div class="mb-3">
                        <label for="escudoEdit" class="form-label">Escudo:</label>
                        <input type="file" class="form-control" id="escudoEdit" name="escudo" accept="image/png, image/jpeg">
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Modal de Edición de jugador -->
<div class="modal fade" id="editarJugadorModal" tabindex="-1" aria-labelledby="editarJugadorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarJugadorModalLabel">Editar Jugador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Formulario para editar un jugador -->
                <form id="formEditarJugador" action="EditarJugador" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="jugadorID" name="jugadorID">
                    <div class="mb-3">
                        <label for="nombreEdit" class="form-label">Nombre del jugador:</label>
                        <input type="text" class="form-control" id="nombreEdit" name="nombreEquipo" required>
                    </div>
                    <div class="mb-3">
                        <label for="edadEdit" class="form-label">Edad del Jugador:</label>
                        <input type="text" class="form-control" id="edadEdit" name="edad" required>
                    </div>
                    <div class="mb-3">
                        <label for="alturaEdit" class="form-label">Altura del Jugador:</label>
                        <input type="text" class="form-control" id="alturaEdit" name="altura" required>
                    </div>
                    <div class="mb-3">
                        <label for="pesoEdit" class="form-label">Peso del Jugador:</label>
                        <input type="text" class="form-control" id="pesoEdit" name="peso" required>
                    </div>
                    <div class="mb-3">
                        <label for="salarioEdit" class="form-label">Salario del Jugador:</label>
                        <input type="text" class="form-control" id="salarioEdit" name="salario" required>
                    </div>
                    <div class="mb-3">
                        <label for="posicionEdit" class="form-label">Posicion del Jugador:</label>
                        <input type="text" class="form-control" id="posicionEdit" name="posicion" required>
                    </div>
                    <div class="mb-3">
                        <label for="fotoEdit" class="form-label">Escudo:</label>
                        <input type="file" class="form-control" id="fotoEdit" name="foto" accept="image/png, image/jpeg">
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Toast para mostrar notificaciones al agregar equipo -->
<div id="toastAgregar" class="toast" role="alert" aria-live="polite" aria-atomic="true" style="position: fixed; top: 20px; right: 20px; z-index: 1000;">
    <!-- Contenido del toast -->
</div>

<!-- Botón para seleccionar equipo y calcular nómina -->
<center>
    <button type="button" class="btn btn-action1" id="btnSeleccionarEquipo" data-bs-toggle="modal" data-bs-target="#seleccionarEquipoModal">Seleccionar Equipo y Calcular Nómina</button>
</center>

<!-- Script para eliminar jugador -->
<script>
    function eliminarJugador(nombreJugador) {
        if (confirm('¿Estás seguro de que deseas eliminar este jugador?')) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'EliminarJugador');
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function () {
                if (xhr.status === 200) {
                    // Si se completó con éxito, redirigir a index.jsp
                    window.location.href = 'index.jsp';
                } else {
                    // Manejar cualquier error
                    console.error('Error al eliminar el jugador:', xhr.statusText);
                }
            };
            xhr.send('nombreJugador=' + encodeURIComponent(nombreJugador));
        }
    }
</script>
<script>
    // Función para cargar los datos del equipo en el modal de edición
    function cargarDatosEdicion(nombreEquipo, director, escudo) {
        // Llenar los campos del modal con los datos del equipo
        document.getElementById('nombreEquipoEditar').value = nombreEquipo;
        document.getElementById('directorEditar').value = director;
        document.getElementById('escudoActual').src = escudo;

        // Mostrar el modal de edición
        var modalEditar = new bootstrap.Modal(document.getElementById('editarEquipoModal'));
        modalEditar.show();
    }

    // Asignar la función cargarDatosEdicion a cada botón "Editar"
    var botonesEditar = document.querySelectorAll('.btn-editar-equipo');
    botonesEditar.forEach(function (boton) {
        boton.addEventListener('click', function () {
            var nombreEquipo = this.getAttribute('data-nombre-equipo');
            var director = this.getAttribute('data-director');
            var escudo = this.getAttribute('data-escudo');
            cargarDatosEdicion(nombreEquipo, director, escudo);
        });
    });
</script>
<!-- Función para enviar una confirmación en ventana emergente -->
<script>
    function eliminarEquipo(nombreEquipo) {
        if (confirm("¿Estás seguro de que quieres eliminar este equipo?")) {
            // Hacer una solicitud GET al servlet EliminarEquipo con el nombre del equipo como parámetro
            var url = "EliminarEquipo?nombreEquipo=" + encodeURIComponent(nombreEquipo);
            fetch(url)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Error en la solicitud.');
                        }
                        // Recargar la página después de eliminar el equipo
                        location.reload();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
        }
    }
</script>
<!-- Scripts para controlar los toasts -->
<script>
    $(document).ready(function () {
        // Función para mostrar el toast correspondiente a la acción realizada (agregar, actualizar o eliminar)
        function mostrarToast() {
    <% String accionAgregar = (String) request.getAttribute("accionAgregar");
        String accionActualizar = (String) request.getAttribute("accionActualizar");
        String accionEliminar = (String) request.getAttribute("accionEliminar");
        String accionDuplicacionID = (String) request.getAttribute("accionDuplicacionID");

        if (accionAgregar != null && accionAgregar.equals("true")) { %>
            // Mostrar el toast de agregar equipo
            $("#toastAgregar").toast('show');
            setTimeout(function () {
                $('#toastAgregar').toast('hide');
            }, 5000);
    <% } else if (accionActualizar != null && accionActualizar.equals("true")) { %>
            // Mostrar el toast de actualizar equipo
            $("#toastActualizar").toast('show');
            setTimeout(function () {
                $('#toastActualizar').toast('hide');
            }, 5000);
    <% } else if (accionEliminar != null && accionEliminar.equals("true")) { %>
            // Mostrar el toast de eliminar equipo
            $("#toastEliminar").toast('show');
            setTimeout(function () {
                $('#toastEliminar').toast('hide');
            }, 5000);
    <% } else if (accionDuplicacionID != null && accionDuplicacionID.equals("true")) { %>
            // Mostrar el toast de duplicación de ID
            $("#toastDuplicacionID").toast('show');
            setTimeout(function () {
                $('#toastDuplicacionID').toast('hide');
            }, 5000);
    <% }%>
        }
        // Llamar a la función para mostrar el toast
        mostrarToast();
    });
</script>
<!-- estilo para botones uno al lado del otro -->
<style>
    .btn-container {
        display: flex;
        justify-content: space-around;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function(){
        // Abre el modal cuando el documento está listo
        $('#reporteNominaModal').modal('show');

        // Obtiene el ID del equipo del modal y lo imprime en la consola
        var idEquipo = '<%= request.getParameter("idEquipo") %>';
        console.log("ID del Equipo:", idEquipo);
        
          $('#reporteNominaModal').on('hidden.bs.modal', function () {
            // Redirige a inicio.jsp
            window.location.href = 'index.jsp';
        });
    });
</script>

<%@include file="lib/footer.jsp"%>

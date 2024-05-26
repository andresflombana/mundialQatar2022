/**
 *
 * Authors: Andrés Lombana y Valentina Alvarez
 */

package com.mundo.mundial;

import java.util.Objects;

public class Equipo {
    private String nombreEquipo;
    private String director;
    private String escudo;

    // Constructor sin argumentos
    public Equipo() {
    }

    // Constructor con todos los campos
    public Equipo(String nombreEquipo, String director, String escudo) {
        this.nombreEquipo = nombreEquipo;
        this.director = director;
        this.escudo = escudo;
    }

    // Getters y Setters
    public String getNombreEquipo() {
        return nombreEquipo;
    }

    public void setNombreEquipo(String nombreEquipo) {
        this.nombreEquipo = nombreEquipo;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getEscudo() {
        return escudo;
    }

    public void setEscudo(String escudo) {
        this.escudo = escudo;
    }

    // Método toString
    @Override
    public String toString() {
        return "Equipo{" +
                "nombreEquipo='" + nombreEquipo + '\'' +
                ", director='" + director + '\'' +
                ", escudo='" + escudo + '\'' +
                '}';
    }

    // Métodos equals y hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Equipo equipo = (Equipo) o;
        return Objects.equals(nombreEquipo, equipo.nombreEquipo) &&
                Objects.equals(director, equipo.director) &&
                Objects.equals(escudo, equipo.escudo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nombreEquipo, director, escudo);
    }
}

package com.cinema.scratch;
import com.cinema.dao.MovieDAO;
import com.cinema.model.Movie;
import java.util.List;

public class CheckMovieData {
    public static void main(String[] args) {
        MovieDAO dao = new MovieDAO();
        List<Movie> movies = dao.findAll();
        System.out.println("--- MOVIE DATA CHECK ---");
        for (Movie m : movies) {
            System.out.println("ID: " + m.getMovieId() + " | Title: " + m.getTitle() + " | Poster: " + m.getPoster());
        }
        System.out.println("------------------------");
    }
}

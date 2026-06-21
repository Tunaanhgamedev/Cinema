package com.cinema.test;

import com.cinema.dao.MovieDAO;
import com.cinema.model.Movie;
import java.util.List;

public class ListMovies {
    public static void main(String[] args) {
        try {
            MovieDAO dao = new MovieDAO();
            List<Movie> all = dao.findAll();
            System.out.println("Total movies in DB: " + all.size());
            for (Movie m : all) {
                System.out.println("- " + m.getTitle() + " | Status: " + m.getStatus());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

package com.cinema.model;

import java.util.Date;

import com.cinema.enums.StatusMovie;

public class Movie {

	private int movieId;
	private String title;
	private String description;
	private String director;
	private String cast;
	private String genre;
	private int duration; // minutes
	private String poster; // filename: poster.jpg
	private String trailerUrl; // youtube link
	private Date releaseDate; // ngày khởi chiếu
	private double rating;
	private StatusMovie status; // NOW_SHOWING / COMING_SOON
	private int reviewCount; // số lượng nhận xét

	public Movie() {
	}

	public Movie(int movieId, String title, String description, String director, String cast, String genre,
			int duration, String poster, String trailerUrl, Date releaseDate, double rating, StatusMovie status, int reviewCount) {

		this.movieId = movieId;
		this.title = title;
		this.description = description;
		this.director = director;
		this.cast = cast;
		this.genre = genre;
		this.duration = duration;
		this.poster = poster;
		this.trailerUrl = trailerUrl;
		this.releaseDate = releaseDate;
		this.rating = rating;
		this.status = status;
		this.reviewCount = reviewCount;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getCast() {
		return cast;
	}

	public void setCast(String cast) {
		this.cast = cast;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public String getTrailerUrl() {
		return trailerUrl;
	}

	public void setTrailerUrl(String trailerUrl) {
		this.trailerUrl = trailerUrl;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public StatusMovie getStatus() {
		return status;
	}

	public void setStatus(StatusMovie status) {
		this.status = status;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
}

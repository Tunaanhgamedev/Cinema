<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Danh sách phim | BOBIXI Cinema</title>
      </head>

      <body class="bg-slate-50">
        <jsp:include page="/common/header.jsp" />

        <main class="min-h-screen py-10">
          <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

            <!-- Professional Toolbar -->
            <div class="bg-white rounded-3xl shadow-sm border border-slate-100 p-6 mb-8">
              <div class="flex flex-col lg:flex-row justify-between items-center gap-6">
                <h1 class="text-3xl font-extrabold text-slate-800 flex items-center gap-3">
                  <span class="bg-red-500 p-2 rounded-xl text-white shadow-sm">🎬</span>
                  DANH SÁCH PHIM
                </h1>

                <div class="flex flex-col md:flex-row items-center gap-4 w-full lg:w-auto">
                  <form action="${pageContext.request.contextPath}/movie" method="GET"
                    class="flex flex-wrap md:flex-nowrap gap-3 w-full">
                    <!-- Search Input -->
                    <div class="relative w-full md:w-80">
                      <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                      <input type="text" name="q" value="${param.q}"
                        class="w-full pl-12 pr-4 py-3 bg-slate-50 border-none rounded-2xl focus:ring-2 focus:ring-red-500 transition-all outline-none text-slate-700"
                        placeholder="Tìm tên phim...">
                    </div>

                    <!-- Sort Dropdown -->
                    <select name="sort" onchange="this.form.submit()"
                      class="px-4 py-3 bg-slate-50 border-none rounded-2xl focus:ring-2 focus:ring-red-500 outline-none text-slate-600 font-semibold cursor-pointer">
                      <option value="newest" ${selectedSort=='newest' ? 'selected' : '' }>Mới nhất</option>
                      <option value="oldest" ${selectedSort=='oldest' ? 'selected' : '' }>Cũ nhất</option>
                      <option value="alphabetical" ${selectedSort=='alphabetical' ? 'selected' : '' }>A - Z</option>
                    </select>
                  </form>

                  <a href="${pageContext.request.contextPath}/showtime"
                    class="w-full md:w-auto bg-slate-800 hover:bg-slate-900 text-white px-8 py-3 rounded-2xl font-bold shadow-lg shadow-slate-200 transition-all text-center whitespace-nowrap">
                    XEM LỊCH CHIẾU
                  </a>
                </div>
              </div>
            </div>

            <!-- Movie Grid -->
            <div id="movieGrid">
              <c:choose>
                <c:when test="${not empty movies}">
                  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                    <c:forEach var="m" items="${movies}">
                      <div
                        class="group bg-white rounded-[2rem] overflow-hidden shadow-sm border border-slate-100 hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                        <div class="relative aspect-[2/3] overflow-hidden">
                          <img src="${pageContext.request.contextPath}/assets/images/movies/${m.poster}"
                            alt="${m.title}"
                            class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                            onerror="this.src='${pageContext.request.contextPath}/assets/images/movies/movie1.jpg'">

                          <div
                            class="absolute inset-0 bg-gradient-to-t from-slate-900/90 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-6">
                            <p class="text-white text-sm font-medium mb-2"><i
                                class="fas fa-clock mr-2 text-yellow-400"></i>${m.duration} phút</p>
                            <p class="text-slate-300 text-xs line-clamp-2">${m.description}</p>
                          </div>
                        </div>

                        <div class="p-6">
                          <div class="flex justify-between items-start mb-2">
                            <h3
                              class="text-xl font-bold text-slate-800 line-clamp-1 group-hover:text-red-600 transition-colors">
                              ${m.title}</h3>
                          </div>

                          <div class="flex items-center gap-3 mb-6">
                            <span
                              class="flex items-center gap-1 text-yellow-500 font-bold bg-yellow-50 px-2 py-1 rounded-lg text-sm">
                              <i class="fas fa-star text-xs"></i> ${m.rating}
                            </span>
                            <span class="text-slate-400 text-sm font-medium">| ${m.genre}</span>
                          </div>

                          <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/movie?id=${m.movieId}"
                              class="flex-1 text-center py-3 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold rounded-xl transition-colors text-sm">
                              Chi tiết
                            </a>
                            <a href="${pageContext.request.contextPath}/booking-seat?movieId=${m.movieId}"
                              class="flex-1 text-center py-3 bg-red-500 hover:bg-red-600 text-white font-bold rounded-xl shadow-lg shadow-red-100 transition-all text-sm">
                              Đặt vé
                            </a>
                          </div>
                        </div>
                      </div>
                    </c:forEach>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="bg-white rounded-3xl p-20 text-center border border-slate-100 shadow-sm">
                    <div
                      class="bg-slate-50 w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-6 text-slate-300">
                      <i class="fas fa-search text-4xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold text-slate-800 mb-2">Không tìm thấy phim</h2>
                    <p class="text-slate-500">Rất tiếc, chúng tôi không tìm thấy bộ phim nào phù hợp với yêu cầu của
                      bạn.</p>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>

          </div>
        </main>

        <jsp:include page="/common/footer.jsp" />

        <script>
          // AJAX Search logic
          const searchInput = document.querySelector('input[name="q"]');
          const sortSelect = document.querySelector('select[name="sort"]');
          const movieGrid = document.getElementById('movieGrid');

          function updateGrid() {
            const q = searchInput.value;
            const sort = sortSelect.value;

            fetch(`${pageContext.request.contextPath}/movie?ajax=true&q=${q}&sort=${sort}`)
              .then(res => res.text())
              .then(html => {
                movieGrid.innerHTML = html;
              });
          }

          let timeout;
          searchInput.addEventListener('input', () => {
            clearTimeout(timeout);
            timeout = setTimeout(updateGrid, 500);
          });
          sortSelect.addEventListener('change', updateGrid);
        </script>
      </body>

      </html>
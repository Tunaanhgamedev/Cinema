<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    .seat {
        width: 40px;
        height: 40px;
        margin: 4px;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        border-radius: 6px;
        font-size: 14px;
    }
    .NORMAL { background: #e0e0e0; }
    .VIP { background: gold; }
    .BOOKED { background: #999; cursor: not-allowed; }
    .SELECTED { background: #e50914; color: white; }
    .COUPLE { background: pink; }
</style>

<h2>Chọn ghế</h2>

<form action="${pageContext.request.contextPath}/booking" method="post">
    <input type="hidden" name="showtimeId" value="${showtimeId}" />

    <c:set var="currentRow" value="" />

    <c:forEach var="s" items="${seats}">
        <c:if test="${currentRow != s.seatRow}">
            <br/>
            <strong>Hàng ${s.seatRow}</strong><br/>
            <c:set var="currentRow" value="${s.seatRow}" />
        </c:if>

        <c:set var="isBooked" value="${bookedSeats.contains(s.seatId)}" />

        <label class="seat
            ${s.seatType}
            ${isBooked ? 'BOOKED' : ''}">
            
            <c:if test="${!isBooked}">
                <input type="checkbox" name="seatIds"
                       value="${s.seatId}"
                       hidden
                       onclick="this.parentElement.classList.toggle('SELECTED')" />
            </c:if>

            ${s.seatRow}${s.seatNumber}
        </label>
    </c:forEach>

    <br/><br/>
    <button type="submit">Tiếp tục đặt vé</button>
</form>

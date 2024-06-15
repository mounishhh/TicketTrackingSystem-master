package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import org.hibernate.Session;
import org.hibernate.Transaction;

import helper.FactoryProvider;
import models.Ticket;

@WebServlet("/UpdateTicket")
public class UpdateTicket extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateTicket() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String priority = request.getParameter("priority");
        String category = request.getParameter("category");

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();
        String message = "";
        Ticket tkt = session.get(Ticket.class, id);
        if (tkt == null) {
            message = "No Ticket Found";
        } else {
            tkt.setTitle(title);
            tkt.setDescription(description);
            tkt.setStatus(status);
            tkt.setPriority(priority);
            tkt.setCategory(category);
            session.merge(tkt);
            tx.commit();
            message = "Ticket updated successfully";
        }
        request.setAttribute("message", message);
        RequestDispatcher rd = request.getRequestDispatcher("update.jsp");
        rd.forward(request, response);
        session.close();
    }
}

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

@WebServlet("/CreateTicket")
public class CreateTicket extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateTicket() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String priority = request.getParameter("priority");
        String category = request.getParameter("category");

        Ticket ticket = new Ticket();
        ticket.setTitle(title);
        ticket.setDescription(description);
        ticket.setStatus(status);
        ticket.setPriority(priority);
        ticket.setCategory(category);

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();
        session.persist(ticket);
        tx.commit();

        String successMessage = "Ticket Created succesfully!";
        request.setAttribute("message", successMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("add.jsp");
        dispatcher.forward(request, response);

        session.close();
    }
}

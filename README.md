# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<label for="tags">Choose a car:</label>

<select id="tags" name="carlist" form="carform">
<%= @tag.each do |t| %>
  <option value="<%t.title%>"><%=t.title%></option>
<% end %>
</select>

        <%= submit_tag "Créer le gossip", class: "btn btn-primary" %>  <%= link_to "Revenir à l'accueil", root_path, :class => 'btn btn-info'%>
</div>
      <% end %>
      
        </form>


        btn btn-cyan btn-sm
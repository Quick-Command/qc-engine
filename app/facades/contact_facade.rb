class ContactFacade
  def self.search(search_term)
    contact = Contact.search(search_term)
    contact.first
  end
end

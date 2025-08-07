reportextension 50862 Reminders extends Reminder
{
    dataset
    {

        // Add changes to dataitems and columns here
        add("Issued Reminder Header")
        {
            column(Customer_ID_; "Customer No.")
            {

            }
            column(Customer_Name; Name)
            {

            }
        }
        add("Issued Reminder Line")
        {
            column(Tax_Invoice; "Document No.")
            {

            }

        }
    }
}
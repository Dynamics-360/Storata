reportextension 50858 CustomerStatementExt extends "Standard Statement"
{
    dataset
    {
        add(Customer)
        {
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }
        }
    }


    rendering
    {
        layout(D360CustomerStatment)
        {
            Type = RDLC;
            LayoutFile = 'D360CustomerStatment.rdl';
        }
    }
}
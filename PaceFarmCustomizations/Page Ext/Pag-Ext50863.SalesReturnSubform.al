pageextension 50863 SalesReturnSubform extends "Sales Return Order Subform"
{
    layout
    {
        addafter(Description)
        {
            // field("Product Relv. Temp."; Rec."Product Relv. Temp.")
            // {
            //     ApplicationArea = All;
            // }
            field("Condition on Arrival"; Rec."Condition on Arrival")
            {
                ApplicationArea = All;
            }
        }
    }
}

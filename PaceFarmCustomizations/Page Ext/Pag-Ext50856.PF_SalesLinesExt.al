pageextension 50856 PF_SalesLines_Ext extends "Sales Lines"
{
    actions
    {
        addafter("&Line")
        {
            action(Delete)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    rec.Delete();
                end;
            }
        }
    }
}

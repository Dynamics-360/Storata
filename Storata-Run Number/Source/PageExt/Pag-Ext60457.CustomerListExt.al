pageextension 60457 PF_CustomerList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Post Code")
        {
            field("Req SSCC"; Rec."Req SSCC")
            {
                ApplicationArea = All;
            }
            field(ReqCOA; Rec.ReqCOA)
            {
                ApplicationArea = All;
            }
            field("Use GLN in Electronic Document"; Rec."Use GLN in Electronic Document")
            {
                ApplicationArea = All;
            }
        }
    }

}
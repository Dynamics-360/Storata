pageextension 50860 PF_PurchaseOrder extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        modify("Print RCTI")
        {
            Visible = false;

        }
        addafter("&Print")
        {
            action("PrintRCTI")
            {
                ApplicationArea = All;
                Caption = 'RCTI Layer';
                Image = Print;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.reset;
                    PurchaseHeader.Setrange(PurchaseHeader."Document Type", Rec."Document Type");
                    PurchaseHeader.Setrange(PurchaseHeader."No.", Rec."No.");
                    if PurchaseHeader.findset then
                        REPORT.RUNMODAL(Report::"PF RCTI", TRUE, TRUE, PurchaseHeader);
                end;
            }
            action("PrintRCTIRental")
            {
                ApplicationArea = All;
                Caption = 'RCTI Rental & Rearing';
                Image = Print;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.reset;
                    PurchaseHeader.Setrange(PurchaseHeader."Document Type", Rec."Document Type");
                    PurchaseHeader.Setrange(PurchaseHeader."No.", Rec."No.");
                    if PurchaseHeader.findset then
                        REPORT.RUNMODAL(Report::"PF_RCTIRental&Rearing", TRUE, TRUE, PurchaseHeader);
                end;
            }
        }
        addafter("&Print_Promoted")
        {
            actionref(PrintRCTI_Promoted01; "PrintRCTI")
            {
            }
            actionref(PrintRCTI_Promoted02; "PrintRCTIRental")
            {
            }
        }
    }

    var
        myInt: Integer;
}
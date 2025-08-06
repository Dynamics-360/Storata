pageextension 60451 SalesOrdExt extends "Sales Order"
{
    layout
    {
        addbefore(Status)
        {
            field("Run No."; Rec."Run No.")
            {
                ApplicationArea = All, Basic, Suite;
            }
            field("Drop No"; Rec."Drop No")
            {
                ApplicationArea = All;
            }
            field("Req SSCC"; Rec."Req SSCC")
            {
                ApplicationArea = All;
            }
            field("Req COA"; Rec."Req COA")
            {
                ApplicationArea = All;
            }
            field("Requires Electronic Invoice"; Rec."Requires Electronic Invoice")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("External Delivery Note"; ExternalDelivNote)
            {
                ApplicationArea = All;
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.SetExternalDeliveryNote(ExternalDelivNote);
                end;
            }
            field("Pick Note"; PickNote)
            {
                ApplicationArea = All;
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.SetExternalDeliveryNote(ExternalDelivNote);
                end;
            }
            field("Posted Invoice Note"; PostedInvNote)
            {
                ApplicationArea = All;
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.SetExternalDeliveryNote(ExternalDelivNote);
                end;
            }
        }
    }
    actions
    {
        modify("Print Confirmation")
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }
        modify(PostAndSend)
        {
            Visible = false;
        }
        modify(SendEmailConfirmation)
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    begin
        ExternalDelivNote := Rec.GetExternalDeliveryNote();
        PickNote := Rec.GetPickNote();
        PostedInvNote := Rec.GetPostedInvoiceNote();
    end;

    var
        ExternalDelivNote: Text;
        PickNote: Text;
        PostedInvNote: Text;
}

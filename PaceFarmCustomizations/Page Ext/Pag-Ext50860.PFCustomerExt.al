pageextension 50860 PFCustomerExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Sales Note"; SalesNote)
            {
                ApplicationArea = All;
                MultiLine = true;
                Caption = 'Sales Note';
                ToolTip = 'Enter any sales-related notes for this customer.';

                trigger OnValidate()
                begin
                    Rec.SetSalesNote(SalesNote);
                end;
            }
            field("Sales Phone Number"; Rec."Sales Phone Number")
            {
                ApplicationArea = All;
                Caption = 'Sales Phone Number';
                ToolTip = 'Enter the sales phone number for this customer.';
            }
            field("Sales Contact"; Rec."Sales Contact")
            {
                ApplicationArea = All;
                Caption = 'Sales Contact';
                ToolTip = 'Select the sales contact for this customer.';
            }

        }
    }
    var
        SalesNote: Text;

    trigger OnAfterGetRecord()
    begin
        SalesNote := Rec.GetSalesNote();
    end;
}

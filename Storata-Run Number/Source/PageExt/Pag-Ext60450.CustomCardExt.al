pageextension 60450 PFCustomerExt extends "Customer Card"
{
    PromotedActionCategories = ',,,,,,,,,,Run Process';
    layout
    {
        addafter("Last Date Modified")
        {
            field("Drop No."; Rec."Drop No.")
            {
                ApplicationArea = All;

            }
            field("Req. Electronic Inv."; Rec."Req. Electronic Inv.")
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
                    Rec.SetPickNote(PickNote);
                end;
            }
            field("Posted Invoice Note"; PostedInvNote)
            {
                ApplicationArea = All;
                MultiLine = true;
                trigger OnValidate()
                begin
                    Rec.SetPostedInvoicekNote(PostedInvNote);
                end;
            }
        }
        addafter("Address & Contact")
        {
            group("Customer SKU's")
            {
                part(CustomSKU; "Customer SKU")
                {
                    Caption = ' ';
                    ApplicationArea = All;
                    SubPageLink = "Customer No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
            group("Customer Runs")
            {
                part(CustomRuns; "Customer Runs")
                {
                    Caption = ' ';
                    ApplicationArea = All;
                    Editable = true;
                    SubPageLink = "Customer No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
        }
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
    actions
    {
        modify(NewSalesOrder)
        {
            Visible = false;
        }
        addafter(NewSalesOrder)
        {
            group(Process)
            {
                Caption = 'Process';
                action("Create Sales Order")
                {
                    ApplicationArea = All;
                    Image = Document;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category11;

                    trigger OnAction()
                    var
                        CustomRun: Record "Customer Runs";
                        CustomRunPag: Page "Customer Runs";
                        RunMgt: Codeunit "Run Number Mgt.";
                    begin
                        CustomRun.Reset();
                        CustomRun.SetRange("Customer No.", Rec."No.");
                        if CustomRun.FindSet() then begin
                            RunMgt.CreateOrder(Rec, CustomRun);
                        end;
                    end;
                }
                action("Update Run Date")
                {
                    ApplicationArea = All;
                    Image = ChangeDate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category11;

                    trigger OnAction()
                    var
                        UpdateCallsDate: Codeunit "Run Number Mgt.";
                        CallSheet: Report "Update Call Sheet";
                    begin
                        UpdateCallsDate.CalcUpdateCalls();
                        Commit();
                        CallSheet.Run();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SalesNote := Rec.GetSalesNote();
        ExternalDelivNote := Rec.GetExternalDeliveryNote();
        PickNote := Rec.GetPickNote();
        PostedInvNote := Rec.GetPostedInvoiceNote();
    end;

    var
        ExternalDelivNote: Text;
        PickNote: Text;
        PostedInvNote: Text;
        SalesNote: Text;
}

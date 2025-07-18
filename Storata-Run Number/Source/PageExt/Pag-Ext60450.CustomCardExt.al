pageextension 60450 CustomCardExt extends "Customer Card"
{
    PromotedActionCategories = ',,,,,,,,,,Run Process';
    layout
    {
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
}

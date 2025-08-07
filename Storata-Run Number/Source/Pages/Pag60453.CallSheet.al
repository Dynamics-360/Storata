page 60453 "Call Sheet"
{
    ApplicationArea = All;
    Caption = 'Call Sheet';
    PageType = List;
    SourceTable = "Call Sheet";
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Customer State"; Rec."Customer State")
                {
                    ToolTip = 'Specifies the value of the Customer State field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                    StyleExpr = StyleExp;
                }
                field("Drop No"; Rec."Drop No")
                {
                    ToolTip = 'Show the value of the Drop No field.', Comment = '%';
                }
                field("Sales Phone Number"; Rec."Sales Phone Number")
                {
                    ToolTip = 'Specifies the value of the Sales Phone Number field.', Comment = '%';
                }
                field("Sales Contact"; Rec."Sales Contact")
                {
                    ToolTip = 'Specifies the value of the Sales Contact field.', Comment = '%';
                }
                field("Run No"; Rec."Run No")
                {
                    ToolTip = 'Specifies the value of the Run No field.', Comment = '%';
                }
                field("Run Day"; Rec."Run Day")
                {
                    ToolTip = 'Specifies the value of the Run Day field.', Comment = '%';
                }
                field("Run Date"; Rec."Run Date")
                {
                    ToolTip = 'Specifies the value of the Run Date field.', Comment = '%';
                    StyleExpr = StyleExpForNewDate;
                }
                field("Call Day"; Rec."Call Day")
                {
                    ToolTip = 'Specifies the value of the Call Day field.', Comment = '%';
                }
                field("Call Group"; Rec."Call Group")
                {
                    ToolTip = 'Specifies the value of the Call Group field.', Comment = '%';
                }
                field("Call Date"; Rec."Call Date")
                {
                    ToolTip = 'Specifies the value of the Call Date field.', Comment = '%';
                }
                field("Sales Note"; SalesNoteTxt)
                {
                    ToolTip = 'Specifies the value of the Sales Note field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Call Back"; Rec."Call Back")
                {
                    ToolTip = 'Specifies the value of the Call Back field.', Comment = '%';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.', Comment = '%';
                }
                field(Holidays; Rec.Holidays)
                {
                    ToolTip = 'Specifies the value of the Holidays field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Customer)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Customer;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomerCard: Page "Customer Card";
                begin
                    if Customer.Get(Rec."Customer No.") then begin
                        CustomerCard.SetRecord(Customer);
                        CustomerCard.Run();
                    end;
                end;
            }
            action("Create Sales Order")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustRun: Record "Customer Runs";
                    CallSheet: Record "Call Sheet";
                    Run: Record "Runs";
                    RunMgt: Codeunit "Run Number Mgt.";
                begin
                    if Customer.Get(Rec."Customer No.") then
                        if CustRun.Get(Rec."Customer No.", Rec."Run No") then
                            RunMgt.CreateOrder(Customer, CustRun);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Closed, false);
    end;

    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Customer No.") then begin
            Rec."Customer Name" := Customer.Name;
            Rec."Customer State" := Customer.County;
            Rec."Sales Phone Number" := Customer."Sales Phone Number";
            Rec.SetNotesTxt(Customer.GetSalesNote());
            Rec.Modify();
            SalesNoteTxt := Rec.GetNotesTxt();
        end;

        UpdateRunDateFromHolidayChanges();

        if Rec.Blocked <> Rec.Blocked::" " then
            StyleExp := 'unfavorable'
        else
            StyleExp := 'None';

        if Rec."Holiday Date Changed" then
            StyleExpForNewDate := 'unfavorable'
        else
            StyleExpForNewDate := 'None';

        CurrPage.Update(false);
    end;

    local procedure UpdateRunDateFromHolidayChanges()
    var
        HolidayChanges: Record "Holiday Changes";
    begin
        HolidayChanges.Reset();
        HolidayChanges.SetRange("Run No", Rec."Run No");
        HolidayChanges.SetRange("Date to be Replaced", Rec."Run Date");
        if HolidayChanges.FindSet() then begin
            Rec."Run Date" := HolidayChanges."New Date";
            Rec."Holiday Date Changed" := true;
            Rec.Modify();
        end;
    end;

    var
        SalesNoteTxt: Text;
        StyleExp: Text;
        StyleExpForNewDate: Text;
}

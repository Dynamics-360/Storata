report 60450 "Update Call Sheet"
{
    Caption = 'Update Call Sheet';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Customer Runs"; "Customer Runs")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Call Date", FromDate, ToDate);
            end;

            trigger OnAfterGetRecord()
            var
                CallSheet: Record "Call Sheet";
            begin
                CallSheet.Reset();
                CallSheet.SetRange("Customer No.", "Customer No.");
                CallSheet.SetRange("Run No", "Run No");
                CallSheet.SetRange("Run Date", "Run Date");
                CallSheet.SetRange("Call Date", "Call Date");
                CallSheet.SetRange("Call Group", "Call Group");
                if CallSheet.FindFirst() then
                    CurrReport.Skip();

                InsertCallSheet("Customer Runs");


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(FromDate; FromDate)
                    {
                        Caption = 'From';
                        ApplicationArea = All;
                    }
                    field(ToDate; ToDate)
                    {
                        Caption = 'To';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        FromDate: Date;
        ToDate: Date;

    local procedure InsertCallSheet(CustomRuns: Record "Customer Runs")
    var
        CallSheetRec: Record "Call Sheet";
        Customer: Record Customer;
        Holidays: Record Holidays;
    begin
        if not Customer.Get(CustomRuns."Customer No.") then
            Error('Customer %1 not found', CustomRuns."Customer No.");

        CallSheetRec.Init();
        CallSheetRec.Validate("Customer No.", "Customer Runs"."Customer No.");
        CallSheetRec.Validate("Run No", CustomRuns."Run No");
        CallSheetRec.Validate("Run Day", CustomRuns."Run Day");
        CallSheetRec.Validate("Run Date", CustomRuns."Run Date");
        CallSheetRec.Validate("Call Day", CustomRuns."Call Day");
        CallSheetRec.Validate("Call Date", CustomRuns."Call Date");
        CallSheetRec.Validate("Customer State", CustomRuns."Customer State");
        CallSheetRec.Validate("Call Group", CustomRuns."Call Group");
        CallSheetRec.SetNotesTxt(Customer.GetSalesNote());
        if CallSheetRec.Insert() then begin
            Holidays.Reset();
            Holidays.SetRange(Date, WorkDate(), CallSheetRec."Call Date");
            Holidays.SetRange(State, CallSheetRec."Customer State");
            if Holidays.FindSet() then begin
                CallSheetRec.Holidays := Holidays.Count;
                CallSheetRec.Modify();
            end;
        end;
    end;
}

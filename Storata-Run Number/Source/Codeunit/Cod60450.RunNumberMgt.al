codeunit 60450 "Run Number Mgt."
{
    trigger OnRun()
    begin
        CalcUpdateCalls();
    end;

    procedure CalcUpdateCalls()
    var
        RunsRec: Record Runs;
        CustRuns: Record "Customer Runs";
    begin
        CustRuns.Reset();
        if CustRuns.FindFirst() then begin
            repeat
                if CustRuns."Run Day" <> 0 then begin
                    CustRuns.Validate("Run Date", GetNextWeekdayDate(WorkDate(), CustRuns."Run Day"));
                    CustRuns.Validate("Call Date", GetCallDate(CustRuns, WorkDate(), CustRuns."Run Day"));
                    CustRuns.Validate("Call Day", Date2DWY(CustRuns."Call Date", 1));
                    CustRuns.Modify();
                end;
            until CustRuns.Next() = 0;
        end;
    end;

    local procedure GetNextWeekdayDate(CurrentDate: Date; WeekdayOption: Integer): Date
    var
        CurrentWeekday: Integer;
        DaysToAdd: Integer;
    begin
        // 1 = Monday, 2 = Tuesday, ..., 7 = Sunday in Business Central Date2DMY weekday calculation
        CurrentWeekday := Date2DWY(CurrentDate, 1);

        // Calculate days to add to reach next WeekdayOption
        DaysToAdd := WeekdayOption - CurrentWeekday;
        if DaysToAdd <= 0 then
            DaysToAdd += 7; // If the day is same or before, add days till next week

        exit(CurrentDate + DaysToAdd);
    end;

    local procedure GetCallDate(var CustRun: Record "Customer Runs"; CurrentDate: Date; WeekdayOption: Integer): Date
    var
        Holidays: Record Holidays;
        Run: Record Runs;
        H_Count: Integer;
        CurrentWeekday: Integer;
        CallWeekday: Integer;
        DaysToAdd: Integer;
        CallDate: Date;
    begin
        Clear(DaysToAdd);
        CurrentWeekday := Date2DWY(CurrentDate, 1);
        if Run.Get(CustRun."Run No") then begin
            // DaysToAdd := ((WeekdayOption - Run."Lead Time") - H_Count - CurrentWeekday);
            DaysToAdd := (WeekdayOption - CurrentWeekday - Run."Lead Time");
            // if DaysToAdd <= 0 then
            //     DaysToAdd += 7; // If the day is same or before, add days till next week
            CallDate := CurrentDate + DaysToAdd;
            CallWeekday := Date2DWY(CallDate, 1);
            if CallWeekday = 7 then
                CallDate := CallDate - 2
            else if CallWeekday = 6 then
                CallDate := CallDate - 1;

            Holidays.Reset();
            Holidays.SetRange(Date, CurrentDate, CallDate);
            Holidays.SetRange(State, CustRun."Customer State");
            if Holidays.FindSet() then begin
                CustRun.Holidays := Holidays.Count;
                CustRun.Modify();
            end;
            exit(CallDate)
        end;
    end;

    procedure CreateOrder(Customer: Record Customer; CustRun: Record "Customer Runs")
    var
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustomerSku: Record "Customer SKU";
        SalesOrderPag: Page "Sales Order";
        LineNo: Integer;
        Count: Integer;
    begin
        // Count := 0;
        if not ShowDefaultSKU(Customer."No.") then
            exit;
        // if CustRun.FindSet() then begin
        //     repeat
        Clear(SalesHead);
        Clear(SalesLine);
        Clear(LineNo);
        SalesHead.Init();
        SalesHead.validate("Document Type", SalesHead."Document Type"::Order);
        SalesHead.Validate("Sell-to Customer No.", Customer."No.");
        SalesHead.Validate("Bill-to Customer No.", Customer."No.");
        SalesHead.validate("Document Date", Today);
        SalesHead.Validate("Run No.", CustRun."Run No");
        if SalesHead.Insert(true) then begin
            Count += 1;
            SKUBuffer.Reset();
            SKUBuffer.SetFilter(Quantity, '>0');
            if SKUBuffer.FindFirst() then begin
                repeat
                    SalesLine.Init;
                    SalesLine.validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Document No.", SalesHead."No.");
                    LineNo += 10000;
                    SalesLine.validate("Line No.", LineNo);
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", SKUBuffer."Item No.");
                    SalesLine.Validate(Quantity, SKUBuffer.Quantity);
                    SalesLine.Validate("Run No.", CustRun."Run No");
                    SalesLine.Insert();
                until SKUBuffer.Next() = 0;
            end;
        end;
        //     until CustRun.Next() = 0;
        // end;

        // if Count = 1 then begin
        if Confirm('Sales Order %1 created for Customer %2. Do you want to open the Sales Order?', true, SalesHead."No.", Customer."No.") then begin
            SalesOrderPag.SetRecord(SalesHead);
            SalesOrderPag.Run();
        end;
        // end else if Count > 1 then begin
        //     Message('%1 Sales Orders are created for customer %2', Count, Customer."No.");
        // end;
    end;

    local procedure ShowDefaultSKU(CustomNo: Code[20]): Boolean
    var
        CustomerSku: Record "Customer SKU";
        CustomSkUPag: Page CustomerSKUBuffer;
        SKUCount: Integer;
    begin
        SKUBuffer.DeleteAll();
        CustomerSku.Reset();
        CustomerSku.SetRange("Customer No.", CustomNo);
        if CustomerSku.FindSet() then begin
            repeat
                SKUBuffer.Init();
                SKUBuffer."Item No." := CustomerSku."Item No.";
                SKUBuffer.Desciption := CustomerSku.Desciption;
                SKUBuffer.Insert();
            until CustomerSku.Next() = 0;
        end;
        SKUCount := SKUBuffer.Count;
        Commit();
        CustomSkUPag.SetTableView(SKUBuffer);
        CustomSkUPag.LookupMode(true);
        if Page.RunModal(Page::CustomerSKUBuffer, SKUBuffer) = Action::LookupOK then
            exit(true)
        else
            exit(false);
    end;

    var
        SKUBuffer: Record DefaultSKUBuffer temporary;
        NotesTxt: Text;
}

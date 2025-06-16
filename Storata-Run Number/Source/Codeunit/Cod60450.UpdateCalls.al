codeunit 60450 "Update Calls"
{
    trigger OnRun()
    begin

    end;

    procedure CalcUpdateCalls(CustRuns: Record "Customer Runs")
    var
        RunsRec: Record Runs;
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

    local procedure GetCallDate(CustRun: Record "Customer Runs"; CurrentDate: Date; WeekdayOption: Integer): Date
    var
        Holidays: Record Holidays;
        Run: Record Runs;
        H_Count: Integer;
        CurrentWeekday: Integer;
        DaysToAdd: Integer;
        CallDate: Date;
    begin
        Clear(DaysToAdd);
        CurrentWeekday := Date2DWY(CurrentDate, 1);
        if Run.Get(CustRun."Run No") then begin
            // DaysToAdd := ((WeekdayOption - Run."Lead Time") - H_Count - CurrentWeekday);
            DaysToAdd := (WeekdayOption - CurrentWeekday - Run."Lead Time");
            if DaysToAdd <= 0 then
                DaysToAdd += 7; // If the day is same or before, add days till next week
            CallDate := CurrentDate + DaysToAdd;

            Holidays.Reset();
            Holidays.SetRange(Date, CurrentDate, CallDate);
            if Holidays.FindSet() then
                H_Count := Holidays.Count;

            if H_Count > 0 then
                exit(CallDate - H_Count)
            else
                exit(CallDate)
        end;
    end;
}

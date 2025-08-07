codeunit 60451 EventMgt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostCommitSalesDoc, '', false, false)]
    local procedure "Sales-Post_OnBeforePostCommitSalesDoc"(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; var ModifyHeader: Boolean; var CommitIsSuppressed: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::"Credit Memo", SalesHeader."Document Type"::Order] then
            CheckSalesLine(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure "Sales-Post_OnAfterPostSalesDoc"(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    begin
        SendElectronicInvoiceToCustomer(SalesInvHdrNo);
    end;

    local procedure CheckSalesLine(SalesHeader: Record "Sales Header")
    var
        SalesLines: Record "Sales Line";
    begin
        SalesLines.Reset();
        SalesLines.SetRange("Document Type", SalesHeader."Document Type");
        SalesLines.SetRange("Document No.", SalesHeader."No.");
        SalesLines.SetFilter(Type, 'Item|G/L Account');
        SalesLines.SetRange(Amount, 0);
        if SalesLines.FindFirst() then
            if not Confirm('You have a line with zero price on Line No. %1. Is this correct?', false, SalesLines."Line No.") then
                Error('You have a line with zero price on Line No %1', SalesLines."Line No.");
    end;

    local procedure SendElectronicInvoiceToCustomer(SalesInvNo: Code[20])
    var
        SalesInvHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
    begin
        if SalesInvHeader.Get(SalesInvNo) then
            if Customer.Get(SalesInvHeader."Sell-to Customer No.") then
                if Customer."Req. Electronic Inv." then begin
                    SalesInvHeader.SetRecFilter();
                    SalesInvHeader.EmailRecords(true);
                    if Confirm('Do you want to print the delivery note?', true) then
                        Report.Run(Report::"PF Delivery Docket", true);
                    if Confirm('Do you want to print the invoice note?', true) then
                        Report.Run(Report::"PF Posted Sales Invoice", true);
                end;
    end;
}

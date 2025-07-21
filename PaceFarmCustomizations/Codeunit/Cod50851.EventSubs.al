codeunit 50851 PFEventSubs
{
    Permissions = tabledata "Return Receipt Header" = RIMD;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure "Sales-Post_OnAfterPostSalesDoc"(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        ReturnRecpt: Record "Return Receipt Header";
    begin
        if ReturnRecpt.Get(RetRcpHdrNo) then begin
            ReturnRecpt.SetWorkDescription(SalesHeader.GetWorkDescription());
            ReturnRecpt.Modify();
        end;
    end;

}

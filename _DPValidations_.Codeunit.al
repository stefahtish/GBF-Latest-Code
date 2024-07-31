codeunit 51001 "DPValidations"
{
    var
        UserSetup: Record "User Setup";
        FilterText: Text;
        Test: text;
        Text1: text;
    // [EventSubscriber(ObjectType::Page, Page::"Chart of Accounts", 'OnOpenPageEvent', '', false, false)]
    // local procedure DoAfterChatofAccListRecords(var Rec: Record "G/L Account")
    // begin
    //     FilterText:=UserResponsibilityCentre();
    //     Rec.FilterGroup(100);
    //     Rec.SetFilter("No.", FilterText);
    //     Rec.FilterGroup(0);
    // end;
    [EventSubscriber(ObjectType::Page, Page::"General Ledger Entries", 'OnOpenPageEvent', '', false, false)]
    local procedure DoAfterGetGLEntriesRecords(var Rec: Record "G/L Entry")
    begin
        FilterText := UserResponsibilityCentre();
        Rec.FilterGroup(100);
        Rec.SetFilter("G/L Account No.", FilterText);
        Rec.FilterGroup(0);
    end;

    procedure UserResponsibilityCentre() RespString: Text[1024];
    var
        RecCount: Integer;
        RestrictedAcc: Record "Account Restrictions";
    begin
        RespString := '';
        RestrictedAcc.Reset();
        RestrictedAcc.SetRange(RestrictedAcc.Userid, UserId);
        RecCount := RestrictedAcc.Count;
        if RestrictedAcc.FindFirst() then
            repeat
                if RestrictedAcc.Count > 1 then
                    RespString := RespString.Trim() + '&<>' + RestrictedAcc."Gl Account"
                else
                    RespString := RespString.Trim() + RestrictedAcc."Gl Account";
            until RestrictedAcc.Next() = 0;
        if RecCount > 1 then begin
            RespString := CopyStr(RespString.Substring(2), 1, MaxStrLen(RespString));
            RespString := CopyStr(RespString.Trim(), 1, MaxStrLen(RespString));
        end;
    end;
}

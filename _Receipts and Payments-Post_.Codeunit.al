codeunit 50101 "Receipts and Payments-Post"
{
    // Meant for Posting of HELB Balances
    trigger OnRun()
    begin
    end;
    var GenSetup: Record "General Ledger Setup";
    procedure PostReceipt()
    var
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Batch: Record "Gen. Journal Batch";
        GLEntry: Record "G/L Entry";
    begin
    /*
        IF CONFIRM('Are you sure you want to post the HELB Receipt Batch no '+HelbHeader.Code+' ?')=TRUE THEN BEGIN
          IF HelbHeader.Posted THEN
             ERROR('The HELB Batch has been posted');
            HelbHeader.TESTFIELD(Date);
            HelbHeader.TESTFIELD(Description);
          GenSetup.GET;
          GenSetup.TESTFIELD("HELB Control Account");
          // Delete Lines Present on the General Journal Line
          GenJnLine.RESET;
          GenJnLine.SETRANGE(GenJnLine."Journal Template Name",GenSetup."Receipt Template");
          GenJnLine.SETRANGE(GenJnLine."Journal Batch Name",HelbHeader.Code);
          GenJnLine.DELETEALL;
          Batch.INIT;
          IF GenSetup.GET() THEN
          Batch."Journal Template Name":=GenSetup."Receipt Template";
          Batch.Name:=HelbHeader.Code;
          IF NOT Batch.GET(Batch."Journal Template Name",Batch.Name) THEN
          Batch.INSERT;
          //Post control account entries
          HelbHeader.CALCFIELDS(HelbHeader."Total Amount");
          LineNo:=LineNo+1000;
          GenJnLine.INIT;
          GenJnLine."Journal Template Name":=GenSetup."Receipt Template";
          GenJnLine."Journal Batch Name":=HelbHeader.Code;
          GenJnLine."Line No.":=LineNo;
          GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
          GenJnLine."Account No.":=GenSetup."HELB Control Account";
          GenJnLine."Posting Date":=HelbHeader.Date;
          GenJnLine."Document No.":=HelbHeader.Code;
          GenJnLine.Description:=HelbHeader.Description;
          GenJnLine.Amount:=HelbHeader."Total Amount";
          GenJnLine.VALIDATE(GenJnLine.Amount);
          GenJnLine."External Document No.":=HelbHeader.Code;
          GenJnLine."Shortcut Dimension 1 Code":=HelbHeader."Global Dimension 1 Code";
          GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
          GenJnLine."Shortcut Dimension 2 Code":=HelbHeader."Global Dimension 2 Code";
          GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
          GenJnLine."Department Code":=HelbLine."Department Code";
          GenJnLine.VALIDATE(GenJnLine."Department Code");
          IF GenJnLine.Amount<>0 THEN
             GenJnLine.INSERT;
         //Post the receipt lines
          HelbLine.SETRANGE(HelbLine.Code,HelbHeader.Code);
          IF HelbLine.FINDFIRST THEN BEGIN
             REPEAT
             HelbLine.VALIDATE(Amount);
             LineNo:=LineNo+1000;
             GenJnLine.INIT;
             GenJnLine."Journal Template Name":=GenSetup."Receipt Template";
             GenJnLine."Journal Batch Name":=HelbHeader.Code;
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
             GenJnLine."Account No.":=HelbLine."Account No";
             GenJnLine.VALIDATE(GenJnLine."Account No.");
             GenJnLine."Posting Date":=HelbHeader.Date;
             GenJnLine."Document No.":=HelbHeader.Code;
             GenJnLine.Description:=HelbLine."Candidate Name"+'-'+'Batch No -'+HelbHeader.Code;
             GenJnLine.Amount:=-HelbLine.Amount;
             GenJnLine.VALIDATE(GenJnLine.Amount);
             GenJnLine."External Document No.":=HelbHeader.Code;
             GenJnLine.VALIDATE(GenJnLine."Currency Code");
             GenJnLine."Shortcut Dimension 1 Code":=HelbLine."Global Dimension 1 Code";
             GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=HelbLine."Global Dimension 2 Code";
             GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
             GenJnLine."Department Code":=HelbLine."Department Code";
             GenJnLine.VALIDATE(GenJnLine."Department Code");
             IF GenJnLine.Amount<>0 THEN
                GenJnLine.INSERT;
             UNTIL
              HelbLine.NEXT=0;
            END;
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnLine);
            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.",HelbHeader.Code);
            GLEntry.SETRANGE(GLEntry.Reversed,FALSE);
            IF GLEntry.FINDFIRST THEN BEGIN
            HelbHeader.Posted:=TRUE;
            HelbHeader."Posted Date":=TODAY;
            HelbHeader."Posted Time":=TIME;
            HelbHeader."Posted By":=USERID;
            HelbHeader.MODIFY;
            END;
        END;
        */
    end;
}

report 50512 "Leave Accrual"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            dataItemTableView = where(status = const(active));

            trigger OnAfterGetRecord()
            var
                StartDate: Date;
                StartDatestr: Text;
                EndDate: date;
                NoOfDays: Decimal;
                HRLedgerEntries: Record "HR Leave Ledger Entries";
                Leavetypes: Record "Leave Type";
                EmpLeavePeriod: Code[20];
                HRmgt: Codeunit "HR Management";
                EntryNo: Integer;
                HRLedgerEntriesRec: Record "HR Leave Ledger Entries";
            begin
                HRLedgerEntriesRec.Reset();
                if HRLedgerEntriesRec.FindLast() then EntryNo := HRLedgerEntriesRec."Entry No.";
                EmpLeavePeriod := HRmgt.GetCurrentLeavePeriod("Employment Type");
                // StartDatestr := '1/1/' + Format(Date2DMY(Today, 3));// commented for testing
                StartDatestr := '1/1/' + Format(Date2DMY(WorkDate(), 3));
                Evaluate(StartDate, StartDatestr);
                // EndDate := CALCDATE('<-CM>', Today); // commented for testing
                EndDate := CALCDATE('<-CM>', WorkDate());
                Leavetypes.Reset();
                Leavetypes.SetRange("Annual Leave", true);
                Leavetypes.SetRange("Allocate Leave Monthly", true);
                if Leavetypes.FindFirst() then begin
                    while (StartDate <= EndDate) do begin
                        HRLedgerEntries.reset;
                        HRLedgerEntries.SetRange("Staff No.", Employee."No.");
                        HRLedgerEntries.SetRange("Leave Date", StartDate);
                        HRLedgerEntries.SetRange("Transaction Type", HRLedgerEntries."Transaction Type"::"Leave Allocation");
                        HRLedgerEntries.SetRange("Leave Entry Type", HRLedgerEntries."Leave Entry Type"::Positive);
                        HRLedgerEntries.setrange("Leave Period Code", EmpLeavePeriod);
                        if not HRLedgerEntries.FindFirst() then begin
                            if Employee."Employment Date" < StartDate then begin
                                EntryNo := EntryNo + 1;
                                HRLedgerEntries.init;
                                HRLedgerEntries."Entry No." := EntryNo;
                                HRLedgerEntries."Staff No." := Employee."No.";
                                HRLedgerEntries."Leave Date" := StartDate;
                                HRLedgerEntries."Leave Period" := StartDate;
                                HRLedgerEntries."Leave Type" := Leavetypes.Code;
                                HRLedgerEntries."Transaction Type" := HRLedgerEntries."Transaction Type"::"Leave Allocation";
                                HRLedgerEntries."Leave Entry Type" := HRLedgerEntries."Leave Entry Type"::Positive;
                                HRLedgerEntries."No. of days" := (Leavetypes.Days / 12);
                                HRLedgerEntries."Leave Period Code" := EmpLeavePeriod;
                                HRLedgerEntries."Leave Posting Description" := 'Allocation for ' + format(StartDate, 0, '<Month Text> <Year,4>');
                                HRLedgerEntries."Document No." := 'ALLOC' + format(StartDate, 0, '<Month,2><Year,4>');
                                HRLedgerEntries.Insert(true);
                                HRLedgerEntries.Validate("Staff No.");
                                HRLedgerEntries.Modify();
                            end;
                        end
                        else begin
                            if Employee."Employment Date" > StartDate then begin
                                if HRLedgerEntries."No. of days" > 0 then begin
                                    HRLedgerEntries."No. of days" := 0;
                                    HRLedgerEntries.Modify()
                                end;
                            end;
                        end;
                        StartDate := CalcDate('1M', StartDate);
                    end;
                end;
            end;
        }
    }
}

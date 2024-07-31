page 50525 "Leave Period"
{
    // DeleteAllowed = false;
    PageType = List;
    SourceTable = "Leave Periods";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Period"; Rec."Leave Period")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(closed; Rec.closed)
                {
                    Editable = false;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                }
                field("Employment Type"; Rec."Employment Type")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Close Period")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    HRSetup.GET;
                    HRSetup.TESTFIELD("Assignment Nos");
                    DocNo := NoSeriesManagement.GetNextNo(HRSetup."Assignment Nos", 0D, TRUE);
                    Employee.RESET;
                    //Employee.SetFilter("Employment Type", '%1|%2', Employee."Employment Type"::Permanent, Employee."Employment Type"::Contract);
                    Employee.SetRange("Employment Type", Rec."Employment Type");
                    Employee.SETRANGE(Status, Employee.Status::Active);
                    IF Employee.FIND('-') THEN
                        REPEAT
                            Leavetype.Reset();
                            Leavetype.SetRange(Balance, Leavetype.Balance::"Carry Forward");
                            Leavetype.SetRange("Annual Leave", true);
                            if Leavetype.FindFirst() then begin
                                Code1 := Leavetype.Code;
                                maxdays := Leavetype."Max Carry Forward Days";
                            end;
                            //close previous positive leave entries
                            LeaveLedger.RESET;
                            LeaveLedger.SETRANGE("Staff No.", Employee."No.");
                            LeaveLedger.SetFilter("Transaction Type", '%1', LeaveLedger."Transaction Type"::"Leave B/F");
                            LeaveLedger.SETRANGE(Closed, FALSE);
                            IF LeaveLedger.FINDFIRST THEN
                                REPEAT
                                    LeaveLedger.Closed := TRUE;
                                    LeaveLedger.MODIFY;
                                UNTIL LeaveLedger.NEXT = 0;
                            LeaveLedger.RESET;
                            LeaveLedger.SETRANGE("Staff No.", Employee."No.");
                            LeaveLedger.SETRANGE(Closed, FALSE);
                            IF LeaveLedger.FINDFIRST THEN BEGIN
                                LeaveLedger.CalcSums("No. of days");
                                LeaveLedger."Entry No." := InitNextEntryNo;
                                if (LeaveLedger."No. of days" >= maxdays) then Broughtfoward := maxdays;
                                if (LeaveLedger."No. of days" <= maxdays) then Broughtfoward := LeaveLedger."No. of days";
                            END;
                            LeaveLedger.RESET;
                            LeaveLedger.SETRANGE("Staff No.", Employee."No.");
                            LeaveLedger.SetRange("Leave Period Code", Rec."Leave Period");
                            LeaveLedger.SetRange("Leave Type", Code1);
                            if LeaveLedger.Find('-') then begin
                                LeaveLedger.INIT;
                                LeaveLedger."Leave Period" := Rec."Start Date";
                                LeaveLedger."Staff No." := Employee."No.";
                                LeaveLedger."Document No." := DocNo;
                                LeaveLedger."Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                                LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
                                LeaveLedger."Job ID" := Employee."Job Title";
                                LeaveLedger."Transaction Type" := LeaveLedger."Transaction Type"::"Leave B/F";
                                LeaveLedger."Job Group" := Employee."Salary Scale";
                                LeaveLedger."Leave Approval Date" := TODAY;
                                LeaveLedger."Leave Period Code" := Rec."Leave Period";
                                LeaveLedger."Contract Type" := FORMAT(Employee."Contract Type");
                                LeaveLedger."Leave Posting Description" := 'Balance B/F for last Accounting Period';
                                LeaveLedger."User ID" := USERID;
                                LeaveLedger."Leave Type" := Code1;
                                LeaveLedger."No. of days" := Broughtfoward;
                                LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                                LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                                LeaveLedger.Insert;
                            end;
                            Employee.MODIFY;
                        UNTIL Employee.NEXT = 0;
                    Message(Success);
                    Rec.closed := true;
                    Rec.Modify;
                end;
            }
        }
    }
    var
        LeaveLedger: Record "HR Leave Ledger Entries";
        Employee: Record Employee;
        EmployeeLeave: Record "Employee Leave";
        Leavetype: Record "Leave Type";
        Success: Label 'The period is closed successfully';
        Code1: Code[20];
        maxdays: Decimal;
        LeaveEntry: Record "HR Leave Ledger Entries";
        Broughtfoward: Decimal;
        DocNo: Code[50];
        NoSeriesManagement: Codeunit "No. Series";
        HRSetup: Record "Human Resources Setup";
        LeavePeriod: Record "Leave Periods";

    LOCAL procedure InitNextEntryNo() NextEntryNo: Integer
    begin
        LeaveEntry.LOCKTABLE;
        IF LeaveEntry.FINDLAST THEN
            NextEntryNo := LeaveEntry."Entry No." + 1
        ELSE
            NextEntryNo := 1;
    end;
}

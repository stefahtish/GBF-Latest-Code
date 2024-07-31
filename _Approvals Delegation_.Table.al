table 50148 "Approvals Delegation"
{
    fields
    {
        field(1; "Delegation No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "Delegation No." <> xRec."Delegation No." then NoSeriesMgt.TestManual(CashMgt."Approvals Delegation Nos.");
            end;
        }
        field(2; "Current User"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(3; "Reason for Delegation"; Text[250])
        {
        }
        field(4; "Delegated To"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Delegated,Resumed';
            OptionMembers = Open, Delegated, Resumed;
        }
        field(6; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Delegation Start Date"; Date)
        {
        }
        field(8; "Date-Time Delegated"; DateTime)
        {
        }
        field(9; "Date-Time Resumed"; DateTime)
        {
        }
        field(10; "Delegation End Date"; Date)
        {
        }
        field(11; "Sequence No."; Integer)
        {
            MinValue = 1;
        }
    }
    keys
    {
        key(Key1; "Delegation No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        CashMgt.Get();
        CashMgt.TestField("Approvals Delegation Nos.");
        if "Delegation No." = '' then NoSeriesMgt.InitSeries(CashMgt."Approvals Delegation Nos.", xRec."No. Series", 0D, "Delegation No.", "No. Series");
        "Current User":=UserId;
    end;
    var CashMgt: Record "Cash Management Setups";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Text000: Label 'Are you sure you want to delegate your approvals to %1?';
    Text001: Label 'Are you sure you want to resume your approvals from %1?';
    Text002: Label 'Delegation %1 has been %2';
    OpenDelegations: Report "Open Delegations";
    SequenceNo: Integer;
    ApprovalDelegations: Report "Approval Delegations";
    ApprovalDelegationsResume: Report "Approval Delegations Resume";
    procedure Delegate(DelegationRec: Record "Approvals Delegation")
    var
        UserRec: Record User;
        Username: Text;
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        WFlowGroupUsers: Record "Workflow User Group Member";
    begin
        DelegationRec.TestField("Current User");
        DelegationRec.TestField("Delegated To");
        DelegationRec.TestField(Status, DelegationRec.Status::Open);
        DelegationRec.TestField("Delegation Start Date");
        DelegationRec.TestField("Delegation End Date");
        UserRec.Reset;
        UserRec.SetRange("User Name", DelegationRec."Delegated To");
        if UserRec.Find('-')then;
        if UserRec."Full Name" <> '' then Username:=UserRec."Full Name"
        else
            Username:=DelegationRec."Delegated To";
        if Confirm(Text000, false, Username)then begin
            //Change Approval Setups
            UserSetup.Reset;
            UserSetup.SetRange("Approver ID", DelegationRec."Current User");
            if UserSetup.Find('-')then repeat UserSetup."Approver ID":=DelegationRec."Delegated To";
                    UserSetup."Delegated From":=DelegationRec."Current User";
                    UserSetup.Modify;
                until UserSetup.Next = 0;
            WFlowGroupUsers.Reset;
            WFlowGroupUsers.SetRange("User Name", DelegationRec."Current User");
            if WFlowGroupUsers.Find('-')then repeat WFlowGroupUsers."Delegated From":=DelegationRec."Current User";
                    SequenceNo:=WFlowGroupUsers."Sequence No.";
                    DelegationRec.Validate("Sequence No.", SequenceNo);
                    WFlowGroupUsers.Rename(WFlowGroupUsers."Workflow User Group Code", DelegationRec."Delegated To", DelegationRec."Sequence No.");
                until WFlowGroupUsers.Next = 0;
            //Modify Existing Entries
            // ApprovalEntry.RESET;
            // ApprovalEntry.SETRANGE("Approver ID","Current User");
            // ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Open,ApprovalEntry.Status::Created);
            // IF ApprovalEntry.FIND('-') THEN
            //   REPEAT
            //     ApprovalEntry."Approver ID":="Delegated To";
            //     ApprovalEntry."Delegated From":="Current User";
            //     ApprovalEntry.MODIFY;
            //   UNTIL
            //    ApprovalEntry.NEXT=0;
            Commit;
            //New Modify:
            ApprovalDelegations.GetDefaults(DelegationRec."Current User", DelegationRec."Delegated To");
            ApprovalDelegations.Run;
            OpenDelegations.SendDelegationEmail(DelegationRec);
            DelegationRec.Status:=DelegationRec.Status::Delegated;
            DelegationRec.Modify;
            Message(Text002, DelegationRec."Delegation No.", 'Delegated Sucessfully!');
        end;
    end;
    procedure Resume(var DelegationRec: Record "Approvals Delegation")
    var
        UserRec: Record User;
        Username: Text;
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        WFlowGroupUsers: Record "Workflow User Group Member";
    begin
        DelegationRec.TestField("Current User");
        DelegationRec.TestField("Delegated To");
        DelegationRec.TestField(Status, DelegationRec.Status::Delegated);
        DelegationRec.TestField("Delegation Start Date");
        DelegationRec.TestField("Delegation End Date");
        UserRec.Reset;
        UserRec.SetRange("User Name", DelegationRec."Delegated To");
        if UserRec.Find('-')then;
        if UserRec."Full Name" <> '' then Username:=UserRec."Full Name"
        else
            Username:=DelegationRec."Delegated To";
        if Confirm(Text001, false, Username)then begin
            //Change Approval Setups
            UserSetup.Reset;
            UserSetup.SetRange("Approver ID", DelegationRec."Delegated To");
            UserSetup.SetRange("Delegated From", DelegationRec."Current User");
            if UserSetup.Find('-')then repeat UserSetup."Approver ID":=DelegationRec."Current User";
                    UserSetup."Delegated From":='';
                    UserSetup.Modify;
                until UserSetup.Next = 0;
            WFlowGroupUsers.Reset;
            WFlowGroupUsers.SetRange("User Name", DelegationRec."Delegated To");
            WFlowGroupUsers.SetRange("Delegated From", DelegationRec."Current User");
            if WFlowGroupUsers.Find('-')then repeat WFlowGroupUsers."Delegated From":='';
                    SequenceNo:=WFlowGroupUsers."Sequence No.";
                    DelegationRec.Validate("Sequence No.", SequenceNo);
                    WFlowGroupUsers.Rename(WFlowGroupUsers."Workflow User Group Code", DelegationRec."Current User", DelegationRec."Sequence No.");
                until WFlowGroupUsers.Next = 0;
            // //Modify Existing Entries
            // ApprovalEntry.RESET;
            // ApprovalEntry.SETCURRENTKEY(Status);
            // ApprovalEntry.SETRANGE("Approver ID","Delegated To");
            // ApprovalEntry.SETRANGE("Delegated From","Current User");
            // ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Open,ApprovalEntry.Status::Created);
            // IF ApprovalEntry.FIND('-') THEN
            //   REPEAT
            //     ApprovalEntry."Approver ID":="Current User";
            //     ApprovalEntry."Delegated From":='';
            //     ApprovalEntry.MODIFY;
            //   UNTIL
            //    ApprovalEntry.NEXT=0;
            Commit;
            //Resume New
            ApprovalDelegationsResume.GetDefaults(DelegationRec."Delegated To", DelegationRec."Current User");
            ApprovalDelegationsResume.Run;
            OpenDelegations.SendResumptionEmail(DelegationRec);
            DelegationRec.Status:=DelegationRec.Status::Resumed;
            DelegationRec.Modify;
            Message(Text002, DelegationRec."Delegation No.", 'Resumed Sucessfully!');
        end;
    end;
}

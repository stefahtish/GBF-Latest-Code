page 50294 "Unprocessed IC Apportions"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Apportionment Entry";
    SourceTableView = WHERE(Processed = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field(Company; Rec.Company)
                {
                }
                field(Allocation; Rec.Allocation)
                {
                }
                field("Posted Doc No."; Rec."Posted Doc No.")
                {
                }
                field(Processed; Rec.Processed)
                {
                }
                field("Expense Account"; Rec."Expense Account")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Apportioned Amount"; Rec."Apportioned Amount")
                {
                }
                field("Line No"; Rec."Line No")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("G/L Entry No"; Rec."G/L Entry No")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Amount To Post"; Rec."Amount To Post")
                {
                }
                field("Apportion Doc No."; Rec."Apportion Doc No.")
                {
                }
                field("Processed Date-Time"; Rec."Processed Date-Time")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("Prepared Date-Time"; Rec."Prepared Date-Time")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Process)
            {
                Caption = 'Process Apportions  Manually';
                Image = ExecuteAndPostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = CounterGreaterThanZero;

                trigger OnAction()
                begin
                    PostApportionment.RunModal;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        CounterGreaterThanZero := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Count > 0 then begin
            CounterGreaterThanZero := true;
            Notify.Scope(NOTIFICATIONSCOPE::LocalScope);
            Notify.Message := NotificationMsg;
            Notify.Send;
        end;
    end;

    var
        NotificationMsg: Label 'You have unprocessed apportions. Kindly restart the Post Apportionment Job Queue or click Process Manually above';
        CounterGreaterThanZero: Boolean;
        Notify: Notification;
        PostApportionment: Report "Post Apportionment";
        RestartMsg: Label 'Restart Job Queue';
}

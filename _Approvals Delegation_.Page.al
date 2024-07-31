page 50203 "Approvals Delegation"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Approvals Delegation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Delegation No."; Rec."Delegation No.")
                {
                    Editable = ShowField;
                }
                field("Current User"; Rec."Current User")
                {
                    Editable = ShowField;
                }
                field("Delegation Start Date"; Rec."Delegation Start Date")
                {
                    Editable = ShowField;
                }
                field("Delegation End Date"; Rec."Delegation End Date")
                {
                    Editable = ShowField;
                }
                field("Reason for Delegation"; Rec."Reason for Delegation")
                {
                    Editable = ShowField;
                }
                field("Delegated To"; Rec."Delegated To")
                {
                    Editable = ShowField;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Delegate)
            {
                Enabled = ShowField;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Delegate(Rec);
                end;
            }
            action(Resume)
            {
                Enabled = ShowField;
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Resume(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetAppearance();
    end;

    var
        [InDataSet]
        ShowField: Boolean;

    local procedure SetAppearance()
    begin
        ShowField := true;
        if Rec.Status = Rec.Status::Resumed then ShowField := false;
    end;
}

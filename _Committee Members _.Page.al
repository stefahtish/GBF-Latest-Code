page 50102 "Committee Members "
{
    Caption = 'Committee Members Evaluation';
    PageType = ListPart;
    SourceTable = "Commitee Member";
    SourceTableView = where("Committee Type" = const(Evaluation), External = const(false));
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = all;
                }
                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        Rec."Tender No." := CommitteeRec."Tender/Quotation No";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
        Rec."Tender No." := CommitteeRec."Tender/Quotation No";
    end;

    var
        CommitteeRec: Record "Tender Committees";

    local procedure GetHeader()
    begin
        if CommitteeRec.Get(Rec."Appointment No") then;
    end;
}

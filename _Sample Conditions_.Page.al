page 50957 "Sample Conditions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Laboratory Setup Type";
    SourceTableView = where(Type=const("Sample Conditions"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Option; Rec.Options)
                {
                    Caption = 'Has options?';
                }
                field("Has Unit of Measure"; Rec."Has Unit of Measure")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Enabled = Rec."Has Unit of Measure";
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(Options)
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Sample Conditions Options";
                Visible = Rec.Options;
                RunPageLink = Condition=field(Name);
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::"Sample Conditions";
    end;
}

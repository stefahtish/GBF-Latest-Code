page 51278 "Training Plan"
{
    //Caption = 'Training Budget';
    DeleteAllowed = false;
    editable = true;
    PageType = Card;
    SourceTable = "G/L Budget Name";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                }
                field("Total Budget Allocation"; Rec."Total Budget Allocation")
                {
                    Visible = false;
                }
                field("Total Training Allocation"; Rec."Total Training Allocation")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Training Allocation field.', Comment = '%';
                }
            }
            part(Control8; "Training Budget Items")
            {
                SubPageLink = "Training Year" = FIELD(Name);
            }
        }
    }
    actions
    {
    }
}

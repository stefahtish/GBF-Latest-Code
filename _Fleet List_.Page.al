page 50452 "Fleet List"
{
    CardPageID = "Fleet Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Fixed Asset";
    SourceTableView = WHERE("Fixed Asset Type" = FILTER(Fleet), "FA Subclass Code" = filter('MV'));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Select Vehicle"; SelectVehicle)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(RecordLinks; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }
    actions
    {
    }
    var
        SelectVehicle: Boolean;

    procedure GetSelection()
    begin
        CurrPage.SetSelectionFilter(Rec);
    end;
}

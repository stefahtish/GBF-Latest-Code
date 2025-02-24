page 51093 "Lab Maintenance Schedule"
{
    Caption = 'Lab Maintenance Schedule';
    PageType = List;
    SourceTable = "Maintenance Registration";
    AutoSplitKey = true;
    DataCaptionFields = "FA No.";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the number of the related fixed asset. ';
                }
                field("Service Date"; Rec."Service Date")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the date when the fixed asset is being serviced.';
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the number of the vendor who services the fixed asset for this entry.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies a comment for the service, repairs or maintenance to be performed on the fixed asset.';
                }
                field("Service Agent Name"; Rec."Service Agent Name")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the name of the service agent who is servicing the fixed asset.';
                }
                field("Service Agent Phone No."; Rec."Service Agent Phone No.")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the phone number of the service agent who is servicing the fixed asset.';
                }
                field("Service Agent Mobile Phone"; Rec."Service Agent Mobile Phone")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the mobile phone number of the service agent who is servicing the fixed asset.';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        FixedAsset: Record "Fixed Asset";
    begin
        Rec.lab := true;
        FixedAsset.Get(Rec."FA No.");
        Rec."Maintenance Vendor No." := FixedAsset."Maintenance Vendor No.";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Rec.lab := true;
    end;
}

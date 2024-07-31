table 50593 "Cluster Regions Lines"
{
    Caption = 'Cluster Regions Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Cluster; Code[100])
        {
            Caption = 'Cluster';
            DataClassification = ToBeClassified;
        }
        field(2; "Region code"; Code[50])
        {
            Caption = 'Region code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                Dimensions.Reset;
                Dimensions.SetRange(Code, "Region code");
                if Dimensions.Find('-')then begin
                    "Region Name":=Dimensions.Name;
                end;
            end;
        }
        field(3; "Region Name"; Text[100])
        {
            Caption = 'Region Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Cluster, "Region code")
        {
            Clustered = true;
        }
    }
    var Dimensions: Record "Dimension Value";
}

using UnityEngine;
using System.Collections;

/// <summary>
/// Dissolve sample. 
/// 
/// Change dissolve texture to verify the dissolve effect.
/// </summary>
public class Dissolve : MonoBehaviour 
{
    void Start()
    {
        float to = 0f;
        float duration = 2f;
        
        // animating alpha to make a dissolve effect of the image.
        LTDescr desc = LeanTween.alpha(this.gameObject, to, duration);
        desc.setEase(LeanTweenType.linear);
        desc.setLoopPingPong();
    }

}
